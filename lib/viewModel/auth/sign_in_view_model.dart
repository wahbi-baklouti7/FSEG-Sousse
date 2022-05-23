import 'package:flutter/material.dart';

import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/services/localStorage/local_storage.dart';
import 'package:fseg_sousse/views/home/home_screen.dart';

import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/widgets/alert.dart';
import 'package:fseg_sousse/widgets/custom_snakbar.dart';
import 'package:fseg_sousse/widgets/toast.dart';

class SignInViewModel extends ChangeNotifier {
  final FireAuth _fireAuth = locator<FireAuth>();

  bool _isObscure = true;

  bool get isObscure => _isObscure;

  Future<void> signInWithEmail(BuildContext context,
      {required String email, required String password}) async {
    AppAlert.loadingIndicator(context);
    String result =
        await _fireAuth.signInWithEmail(email: email, password: password);

    if (result == "success") {
      LocalStorage.saveLogin(value: true);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, HomeView.id, (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
      AppSnackBar.errorSnackBar(context, content: result);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    AppAlert.loadingIndicator(context);
    String result = await _fireAuth.signInWithGoogle();
    if (result == "success") {
      LocalStorage.saveLogin(value: true);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(
        context,
        HomeView.id,
      );
    } else {
      Navigator.pop(context);
      ShowToast.showToast(content: result);
    }
  }

  void toggle() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<void> signOut(context) async {
    await _fireAuth.signOut();

    LocalStorage.saveLogin(value: false);
  }
}
