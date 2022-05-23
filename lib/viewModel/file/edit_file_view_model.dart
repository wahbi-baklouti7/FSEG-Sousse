import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/utilities/file_utilities.dart';
import 'package:fseg_sousse/widgets/custom_snakbar.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/services/database/database.dart';
import 'package:fseg_sousse/utilities/app_permission.dart';
import 'package:fseg_sousse/viewModel/file/file_view_model.dart';
import 'package:path/path.dart';
import 'package:fseg_sousse/locator.dart';

import 'package:provider/provider.dart';

class EditFileViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final FireAuth _fireAuth = locator<FireAuth>();

  File? _file;
  String? _fileName;
  bool _isSmallFile = true;
  String? _uniqueFileName;
  UploadTask? task;
  int? _progress;

  int? get progressIndicator => _progress;
  bool get isSmallFile => _isSmallFile;
  String? get fileName => _fileName;
  File? get file => _file;

  // open file storage to select and choose a pdf file
  void selectFile() async {
    FilePickerResult? filePicked;

    AppPermissionUtils.checkStoragePermission(onPermissionGranted: () async {
      filePicked = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          
          allowCompression: true,
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
          _fileName = basename(filePath);
          var currentDate = DateTime.now();
          _uniqueFileName = "$currentDate " + _fileName!;
          notifyListeners();
        } else {
          AppSnackBar.errorSnackBar(context,
              content: "Allowed maximum file size is 5MB");
        }
      }
    }, onPermissionDenied: () {
      AppSnackBar.normalSnackBar(context,
          content: " Permission has been denied");
    });
  }

  // add the new file to firebase storage, and then update the download url in firestore for
  // the selected file, finaly delete the old file in storage.
  void editFile(context, {required String fileId, required String url}) async {
    final _user = _fireAuth.currentUser;

    task = _databaseService.updateFileOnStorage(
      filePath: _file!,
      fileName: _uniqueFileName!,
    );
    notifyListeners();

    if (task == null)
      AppSnackBar.normalSnackBar(context,
          content: "Something going wrong, Try again");
    uploadStatus();
    final taskSnapshot = await task!.whenComplete(() {});
    final urlDownload = await taskSnapshot.ref.getDownloadURL();
    await _databaseService.updateFileDocument(
        fileId: fileId,
        model: PdfFileModel(
          addedTime: Timestamp.now(),
          fileUrl: urlDownload,
          name: _fileName,
          userUid: _user!.uid,
        ));

    await _databaseService.deleteFileFromStorage(url);
    _file = null;
    notifyListeners();

    // get the last snapshot of data, and refresh the Ui  according to it.
    Provider.of<FileViewModel>(context, listen: false).refresh(context);
    // Navigator.popUntil(context, ModalRoute.withName(PdfFileScreen.id));
    // Navigator.pushReplacementNamed(context, PdfFileScreen.id);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    AppSnackBar.completeSnackBar(context, content: "File updated successfully");
  }

  // calculate the current progress of uploading the file
  void uploadStatus() {
    task!.snapshotEvents.listen((event) {
      final result = (event.bytesTransferred / event.totalBytes);
      _progress = (result * 100).toInt();
      notifyListeners();
    });
  }
}
