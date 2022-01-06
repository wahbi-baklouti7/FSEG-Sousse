import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuth {
  //return current user
  User? get getUser => FirebaseAuth.instance.currentUser;

  // sing up with email and password
  static Future<String?> signUpWithEmail(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? message;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        message = "success";
        await userCredential.user!.sendEmailVerification();
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
  static Future<String?> signInWithEmail(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? message;
    User? user;
    // print(" email verified: ${auth.currentUser!.emailVerified}");
    try {
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("check before reload: ${userCredential.user!.emailVerified}");
      //  print("${auth.currentUser!.emailVerified}");
      //  userCredential.user!.getIdToken(true);

      user = userCredential.user;
      user!.reload();
      print("check after reload: ${userCredential.user!.emailVerified}");
      print("user: $user");

      //  print("user1 : $user1");

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

  // sign in method with google account
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

  // reset password with address email link
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
}
