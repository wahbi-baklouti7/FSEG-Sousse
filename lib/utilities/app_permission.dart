import 'package:permission_handler/permission_handler.dart';

class AppPermissionUtils {
  static Future checkStoragePermission(
      {required Function onPermissionGranted,
      required Function onPermissionDenied}) async {
    var _storageStatus = await Permission.storage.request();
    switch (_storageStatus) {
      case PermissionStatus.granted:
        onPermissionGranted();
        break;

      case PermissionStatus.denied:
        onPermissionDenied();
        break;

      case PermissionStatus.restricted:
        await openAppSettings();
        break;

      case PermissionStatus.permanentlyDenied:
        await openAppSettings();
        break;

      case PermissionStatus.limited:
        await openAppSettings();
        break;
    }
  }
}
