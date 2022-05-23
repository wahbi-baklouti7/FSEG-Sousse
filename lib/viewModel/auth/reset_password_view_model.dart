import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/widgets/custom_snakbar.dart';
import 'package:fseg_sousse/widgets/toast.dart';

class ResetPasswordViewModel {
  final FireAuth _fireAuth = locator<FireAuth>();

  Future<void> resetPassword(context, {required String email}) async {
    String? result = await _fireAuth.resetPassword(email: email);
    if (result == "success") {
      AppSnackBar.normalSnackBar(context,
          content: "A password sent link has been sent to $email");
    } else {
      AppSnackBar.errorSnackBar(context, content: result!);
    }
  }
}
