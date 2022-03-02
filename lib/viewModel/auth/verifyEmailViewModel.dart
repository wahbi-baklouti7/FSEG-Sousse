import 'package:flutter/cupertino.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/views/home/homeView.dart';

class VerifyEmailViewModel extends ChangeNotifier {
  bool _isEmailVerified = false;
  bool _canResend = true;

  bool get canResend => _canResend;

  bool get isEmailVerified => _isEmailVerified;

  Future sendEmailVerification() async {
    await FireAuth.sendEmailVerification();
    notifyListeners();
  }

  Future checkEmailVerification(BuildContext context) async {
    bool result = await FireAuth.checkEmailVerified();
    _isEmailVerified = result;
    if (_isEmailVerified) {
      Navigator.pushReplacementNamed(context, HomeView.id);
    }
    notifyListeners();
  }

  /// resent new email link verification
  Future resendEmailLinkVerification() async {
    await FireAuth.sendEmailVerification();
    _canResend = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    _canResend = true;
    notifyListeners();
  }
}
