import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/services/conectivity/conecetivity_service.dart';
import 'package:fseg_sousse/services/database/database.dart';
import 'package:fseg_sousse/utilities/app_permission.dart';
import 'package:fseg_sousse/utilities/connectivity_status_enum.dart';
import 'package:fseg_sousse/utilities/file_utilities.dart';
import 'package:fseg_sousse/viewModel/file/file_view_model.dart';
import 'package:fseg_sousse/widgets/alert.dart';
import 'package:fseg_sousse/widgets/custom_snakbar.dart';
import 'package:provider/provider.dart';

class OpenPdfViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final ConnectivityService _connectivityService = ConnectivityService();
  double _progress = 0;

  double get downloadProgress => _progress;

  // It downloads a file from a given url and saves it to the device's storage

  Future<void> downloadPdfFile(context,
      {required String url, required String fileName}) async {
    
    
      Dio _dio = Dio();
      final _path = FileUtils.createFilePath(fileName: fileName);
      print(
          "*********************** Dwonload Path: $_path **********************");
      _progress = 0;

      await AppPermissionUtils.checkStoragePermission(
          onPermissionGranted: () async {
        print(
            "*********************** in download function **********************");
        _dio.download(url, _path,
            onReceiveProgress: (recivedBytes, totalBytes) {
          _progress = recivedBytes / totalBytes * 100;
          notifyListeners();
        }).then((value) {
          Navigator.pop(context);
          print(
              "*********************** Dwonload Path: $_path **********************");
          AppSnackBar.completeSnackBar(context,
              content: "File downloaded successfully");
        }).catchError((err) {
          print(err.toString());
          // AppSnackBar.normalSnackBar(context, content: err.toString());
        });
      }, onPermissionDenied: () {
        Navigator.pop(context);
        AppSnackBar.normalSnackBar(context,
            content: " Permission has been denied");
      });
  }

  // It deletes a file from the database and storage, and then refreshes the UI

  Future<void> deleteFile(context,
      {required String uid, required String fileUrl}) async {

    // Checking if the user is connected to the internet or not.
    if (await _connectivityService.checkInternetConnection() ==
        ConnectivityStatus.offline) {
      AppSnackBar.normalSnackBar(context, content: "No network connection");
    } 
    else {
      AppAlert.confirmationDialog(context, onConfirm: () async {
        await _databaseService.deleteFile(fileId: uid);

        await _databaseService.deleteFileFromStorage(fileUrl);
        notifyListeners();

        // get the last snapshot of data, and refresh the Ui  according to it.
        await Provider.of<FileViewModel>(context, listen: false)
            .refresh(context);

        Navigator.pop(context);
        Navigator.pop(context);

        AppSnackBar.completeSnackBar(context,
            content: "File deleted successfully");
      }, onCancel: () {
        Navigator.pop(context);
      });
    }
  }
}
