import 'package:flutter/material.dart';
import 'package:fseg_sousse/components/toast.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';

class SignUpViewModel {
  static signUpWithEmail(
      {required String email, required String password}) async {
    String? result =
        await FireAuth.signUpWithEmail(email: email, password: password);

    if (result == "success") {
      ShowToast.toastSuccess(content: "A verification link has been sent to your email account",color: Colors.grey);
    } else {
      // print(result);
      ShowToast.toastError(content: result??"Try Again");
    }
  }
}
