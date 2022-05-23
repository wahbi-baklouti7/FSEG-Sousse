import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fseg_sousse/models/user.dart';
import 'package:fseg_sousse/services/database/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 /// A getter that returns the current user.
  User? get currentUser => _auth.currentUser;

  /// send email verification to user
  Future<void> sendEmailVerification() async {
    try {
      User? _user = _auth.currentUser;
      await _user!.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  /// check if email is verified or not
  Future<bool> checkEmailVerified() async {
    await _auth.currentUser!.reload();
    return _auth.currentUser!.emailVerified;
  }

  // sing up with email and password
  Future<String?> signUpWithEmail(
      {required String email,
      required String password,
      required String fullName}) async {
    String? message;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        message = "success";

        DatabaseService().createUser(UserModel(
            uid: userCredential.user!.uid,
            fullName: fullName,
            email: email,
            contribution: 0,
            accountCreated: Timestamp.now()));
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        message = "The email address is already used";
      }
    } catch (e) {
      message = e.toString();
    }
    return message;
  }

  // sing in method with email and password
  Future<String> signInWithEmail(
      {required String email, required String password}) async {
    String message = "error";
    User? user;

    try {
      UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      user = userCredential.user;

      if (user != null) {
        // before sign in check if user email is verified or not
        if (user.emailVerified) {
          message = "success";
        } else {
          message = "Please Verify your address email";
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect Password";
      }
    } catch (e) {
      message = e.toString();
    }

    return message;
  }

  // sign in method with google account
  Future<String> signInWithGoogle() async {
    String message = "error";

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        message = "success";

        // check if user is new
        // if ture
        // store user data  in firestore
        if (userCredential.additionalUserInfo!.isNewUser) {
          await DatabaseService().createUser(UserModel(
              uid: userCredential.user!.uid,
              fullName: userCredential.user!.displayName,
              email: userCredential.user!.email,
              contribution: 0,
              accountCreated: Timestamp.now()));
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        message = 'Account already exist  with this email';
      } else if (e.code == 'invalid-credential') {
        message = "Error occurred while accessing credentials. Try again.";
      }
    } catch (e) {
      message = 'Error occurred using Google Sign-In. Try again.';
    }
    return message;
  }

  /// reset password with address email link
  Future<String?> resetPassword({required String email}) async {
    String? message;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      message = "success";
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        message = "There is no user corresponding to the email address";
      }
    } catch (error) {
      message = error.toString();
    }
    return message;
  }

  Future<void> signOut() async {
    final userInfo = _auth.currentUser!.providerData[0]; // get user info
    try {
      // check if the user login with email or google account
      if (userInfo.providerId == "google.com") {
        await _auth.signOut();

        await GoogleSignIn().signOut();
      } else {
        await _auth.signOut();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
