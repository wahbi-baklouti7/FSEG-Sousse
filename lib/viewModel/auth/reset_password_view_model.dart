import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/utilities/connectivity_utility.dart';
import 'package:fseg_sousse/widgets/custom_snackbar.dart';

class ResetPasswordViewModel {
  final FireAuth _fireAuth = locator<FireAuth>();

  Future<void> resetPassword(context, {required String email}) async {

    if(await ConnectivityUtility.checkInternet(context)){
        String? result = await _fireAuth.resetPassword(email: email);
    if (result == "success") {
      AppSnackBar.normalSnackBar(context,
          content: "A password sent link has been sent to $email");
    } else {
      AppSnackBar.errorSnackBar(context, content: result!);
    }
    }
  }
}
