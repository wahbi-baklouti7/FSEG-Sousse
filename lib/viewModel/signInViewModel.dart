import 'package:flutter/material.dart';
import 'package:fseg_sousse/components/alert.dart';
import 'package:fseg_sousse/components/toast.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';

class SignInViewModel {
  static void signInWithEmail(
      {required String email, required String password}) async {
    String? result =
        await FireAuth.signInWithEmail(email: email, password: password);

    print("result: $result");

    if (result == "success") {
      ShowToast.toastSuccess(
          content: "Login Successfully", color: Colors.green);
    } else {
      // print(result);
      ShowToast.toastError(content: result!);
    }
  }

  static void signInWithGoogle(BuildContext context) async {
    AppAlert.progressIndicator(context);
    String? result = await FireAuth.signInWithGoogle();
    if (result == "success") {
      Navigator.pop(context);
      ShowToast.toastSuccess(
          content: "Login Successfully", color: Colors.green);
    } else {
      // print(result);
      ShowToast.toastError(content: result ?? "try again");
    }
  }
}
