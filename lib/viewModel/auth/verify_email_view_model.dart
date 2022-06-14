import 'package:flutter/material.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/services/localStorage/local_storage.dart';
import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/views/home/home_screen.dart';

class VerifyEmailViewModel extends ChangeNotifier {
  final FireAuth _fireAuth = locator<FireAuth>();

  bool _isEmailVerified = false;
  bool _canResend = true;

  bool get canResend => _canResend;

  bool get isEmailVerified => _isEmailVerified;

  Future<void> sendEmailVerification() async {
    await _fireAuth.sendEmailVerification();
    notifyListeners();
  }

  Future<void> checkEmailVerification(BuildContext context) async {
    bool result = await _fireAuth.checkEmailVerified();
    _isEmailVerified = result;
    if (_isEmailVerified) {
       LocalStorage.saveUserId( id: _fireAuth.currentUser!.uid);
      Navigator.pushReplacementNamed(context, HomeView.id);
    }
    notifyListeners();
  }

  /// resent new email link verification
  Future<void> resendEmailLinkVerification() async {
    await _fireAuth.sendEmailVerification();
    _canResend = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    _canResend = true;
    notifyListeners();
  }
}
