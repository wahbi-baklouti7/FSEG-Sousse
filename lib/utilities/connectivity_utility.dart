import 'package:fseg_sousse/widgets/custom_snackbar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityUtility {
  static final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker();

  static Future<bool> checkInternet(context) async {
    final hasInternet = await _internetConnectionChecker.hasConnection;
    if (!hasInternet) {
      AppSnackBar.normalSnackBar(context, content: "No internet connection");
    }

    return hasInternet;
  }
}
