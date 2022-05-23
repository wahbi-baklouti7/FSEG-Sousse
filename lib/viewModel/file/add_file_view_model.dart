import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/services/database/database.dart';
import 'package:fseg_sousse/utilities/app_permission.dart';
import 'package:fseg_sousse/utilities/file_utilities.dart';
import 'package:fseg_sousse/viewModel/file/file_view_model.dart';
import 'package:fseg_sousse/widgets/custom_snakbar.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddFileViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final FireAuth _fireAuth = locator<FireAuth>();

  File? _file;
  String? _fileName;
  bool _isSmallFile = true;
  String? _uniqueFileName;
  UploadTask? task;
  int _progress = 0;

  int get progressIndicator => _progress;
  bool get isSmallFile => _isSmallFile;
  String? get fileName => _fileName;
  File? get file => _file;

  // open file storage to choose a pdf file

  /// It checks if the user has granted the app permission to access the storage, if yes, it opens the
  /// file picker and allows the user to choose a file, if the user chooses a file, it checks the file
  /// size and if the file size is less than 5MB, it sets the file to a variable and notifies the
  /// listeners, if the file size is greater than 5MB, it shows an error message and notifies the
  /// listeners

  void chooseFile(context) async {
    FilePickerResult? filePicked;

    AppPermissionUtils.checkStoragePermission(onPermissionGranted: () async {
      filePicked = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowCompression: false,
          allowMultiple: false,
          allowedExtensions: ['pdf']);

      // check if the user pick a file or not
      if (filePicked != null) {
        final filePath = filePicked!.files.single.path;
        _file = FileUtils.createFile(path: filePath!);
        _isSmallFile = FileUtils.checkFileSize(_file!);
        notifyListeners();

        // check choosed file size
        if (_isSmallFile) {
          var currentDate = DateTime.now();
          _fileName = basename(filePath);
          _uniqueFileName = "$currentDate" + _fileName!;

          notifyListeners();
        } else {
          _file = null;
          AppSnackBar.errorSnackBar(context,
              content: "Allowed maximum size is 5MB");

          notifyListeners();
        }
      }
    }, onPermissionDenied: () {
      AppSnackBar.normalSnackBar(context,
          content: " Permission has been denied");
    });
  }

  // upload a file to firebase storage,
  // add the file's url and user id to firestore
  void addFile({
    context,
  }) async {
    final _user = _fireAuth.currentUser;

    task = _databaseService.uploadFile(
      filePath: _file!,
      fileName: _uniqueFileName!,
    );

    if (task == null) {
      AppSnackBar.normalSnackBar(context,
          content: "Something going wrong, Try again");
    }
    uploadStatus();
    final taskSnapshot = await task!.whenComplete(() {});
    final urlDownload = await taskSnapshot.ref.getDownloadURL();

    await _databaseService.addFile(
        model: PdfFileModel(
      addedTime: Timestamp.now(),
      fileUrl: urlDownload,
      name: _fileName,
      userUid: _user!.uid,
    ));

    // get the last snapshot of data, and refresh the Ui  according to it.
    Provider.of<FileViewModel>(context, listen: false).refresh(context);

    Navigator.pop(context);
    _fileName = null;
    _file = null;
    notifyListeners();

    AppSnackBar.completeSnackBar(context,
        content: "File uploaded successfully");
  }

  // calculate the current progress of uploading the file
  void uploadStatus() {
    _progress = 0;
    task!.snapshotEvents.listen((event) {
      final result = (event.bytesTransferred / event.totalBytes);
      _progress = (result * 100).toInt();
      notifyListeners();
    });
  }
}
