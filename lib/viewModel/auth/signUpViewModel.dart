import 'package:flutter/material.dart';
import 'package:fseg_sousse/components/toast.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/views/auth/verifyEmailView.dart';

class SignUpViewModel {
  static signUpWithEmail(
    BuildContext context,
      {required String email, required String password ,required String fullName}) async {
    String? result =
        await FireAuth.signUpWithEmail(email: email, password: password,fullName: fullName);

    if (result == "success") {
      
      Navigator.pushNamed(
          context, VerifyEmailScreen.id);
    } else {
      ShowToast.toastError(content: result??"Try Again");
    }
  }
}
