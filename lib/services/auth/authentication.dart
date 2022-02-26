import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fseg_sousse/models/user.dart';
import 'package:fseg_sousse/services/database/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuth {

  /// return current user
  static User? get getUser => FirebaseAuth.instance.currentUser;


  /// send email verification
  static Future<void> sendEmailVerification() async {
    FirebaseAuth _auth =  FirebaseAuth.instance;
    try {
      User? _user = _auth.currentUser;
      await _user!.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

    /// check if email is verified or not 
  static Future<bool> checkEmailVerified() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.currentUser!.reload();
    return _auth.currentUser!.emailVerified;
  }


  /// sing up with email and password
  static Future<String?> signUpWithEmail(
      {required String email,
      required String password,
      required String fullName}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? message;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        message = "success";

        OurDatabase().createUser(UserModel(
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


  /// sing in method with email and password
  static Future<String?> signInWithEmail(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? message;
    User? user;

    try {
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      user = userCredential.user;

      if (user != null) {
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
      print(e.toString());
      message = e.toString();
    }

    return message;
  }


  /// sign in method with google account
  static Future<String?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? message;

    await GoogleSignIn().disconnect();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        message = "success";
        if (userCredential.additionalUserInfo!.isNewUser) {
          // Creating user in firestore
          OurDatabase().createUser(UserModel(
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
  static Future<String?> resetPassword({required String email}) async {
    String? message;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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

  static Future<void> signOut()async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
     await _auth.signOut();
     
    } catch (e) {
      print(e.toString());
    }
  }
}
