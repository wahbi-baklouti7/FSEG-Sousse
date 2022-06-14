import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/locator.dart';

import 'package:fseg_sousse/services/database/database.dart';
import 'package:fseg_sousse/utilities/app_permission.dart';
import 'package:fseg_sousse/utilities/connectivity_utility.dart';
import 'package:fseg_sousse/utilities/file_utilities.dart';
import 'package:fseg_sousse/views/files/edit_file_screen.dart';
import 'package:fseg_sousse/widgets/alert.dart';
import 'package:fseg_sousse/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class FileViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final portPodcast = StreamController.broadcast();
  final ReceivePort _port = ReceivePort();
  late StreamSubscription portStream;

  bool _loadData = true;
  bool _hasNext = true;
  List<PdfFileModel> _cachedList = [];
  DocumentSnapshot? startAfterDoc;

  List<PdfFileModel> get listOfPdfModel => _cachedList;
  bool get hasNext => _hasNext;
  bool get loadData => _loadData;

  void init() {
    _cachedList = [];
    startAfterDoc = null;
  }

  Future<void> getPdfFiles(context) async {
    _loadData = true;
    final listOfDoc = await _databaseService.getPdfFiles(
      startAfter: startAfterDoc,
    );

    _hasNext = hasNextData(listOfDoc);
    if (listOfDoc.isNotEmpty) {
      startAfterDoc = listOfDoc.last;

      final pdList = listOfDoc.map((document) {
        return PdfFileModel.fromMap(document.data() as Map<String, dynamic>);
      }).toList();

      _cachedList = [..._cachedList, ...pdList];
    }
    _loadData = false;

    notifyListeners();
  }

  // Check if there are more data to show to user.
  bool hasNextData(List data) {
    if (data.length >= 10) {
      return true;
    } else {
      return false;
    }
  }

  // call this function when pull down to refresh data
  Future<void> refresh(context) async {
    _cachedList = [];
    startAfterDoc = null;
    await getPdfFiles(context);
  }

  // get more data when scroll down
  Future<void> loadMore(context) async {
    if (!_hasNext) return;
    await getPdfFiles(context);
  }

  // Handel user action in pop up menu, and do work according to it
  Future actionPopUpMenuItem(context,
      {required String value, required PdfFileModel pdfFileModel}) async {
    switch (value) {
      // if the user chose edit item will navigate to edit screen.
      case "Edit":
        if (await ConnectivityUtility.checkInternet(context)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditFileScreen(
                        selectedFile: pdfFileModel,
                      )));
        }
        break;

      // if the choose delete item, it will delete the selected file
      case "Delete":
        await deleteFile(context,
            uid: pdfFileModel.id!, fileUrl: pdfFileModel.fileUrl!);
        break;
    }
  }

  // It deletes a file from the database and storage, and then refreshes the UI
  Future<void> deleteFile(context,
      {required String uid, required String fileUrl}) async {
    if (await ConnectivityUtility.checkInternet(context)) {
      AppAlert.confirmationDialog(context, onConfirm: () async {
        await _databaseService.deleteFile(fileId: uid);

        await _databaseService.deleteFileFromStorage(fileUrl);
        Navigator.pop(context);
        // get the last snapshot of data, and refresh the Ui  according to it.
        Provider.of<FileViewModel>(context, listen: false).refresh(context);
        AppSnackBar.completeSnackBar(context,
            content: "File deleted successfully");
      }, onCancel: () {
        Navigator.pop(context);
      });
    }
  }

  // It downloads a file from a given url and saves it to the device's storage
  Future<void> downloadPdfFile(context,
      {required String url, required String fileName}) async {
    final _path = await FileUtils.createFilePath(fileName: fileName);

    await AppPermissionUtils.checkStoragePermission(
        onPermissionGranted: () async {
      await FlutterDownloader.enqueue(
              url: url,
              savedDir: _path,
              showNotification: true,
              fileName: fileName,
              saveInPublicStorage: true)
          .catchError((onError) {
        print(onError);
      });
    }, onPermissionDenied: () {
      AppSnackBar.normalSnackBar(context,
          content: " Permission has been denied");
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void downloadListener() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    portStream = portPodcast.stream.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status.toString() == "DownloadTaskStatus(3)" &&
          progress == 100 &&
          id != null) {
        String query = "SELECT * FROM task WHERE task_id='" + id + "'";
        var tasks = FlutterDownloader.loadTasksWithRawQuery(query: query);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> cancelStream() async {
    await portPodcast.close();
    await portStream.cancel();
  }
}
