import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/locator.dart';

import 'package:fseg_sousse/services/database/database.dart';

class FileViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = locator<DatabaseService>();

  List<PdfFileModel> _cahchedList = [];
  bool _loadData = true;
  bool _hasNext = true;
  DocumentSnapshot? startAfterDoc;

  List<PdfFileModel> get listOfPdfModel => _cahchedList;
  bool get hasNext => _hasNext;
  bool get loadData => _loadData;

  void intit() {
    _cahchedList = [];
    startAfterDoc = null;
  }

//==========================================================================================================
  Future<void> getpdfFiles(context) async {
    _loadData = true;

    final listOfDoc = await _databaseService.getPdfFiles(
      startAfter: startAfterDoc,
    );

    if (listOfDoc.isNotEmpty) {
      startAfterDoc = listOfDoc.last;

      _hasNext = (listOfDoc.length >=
          10); // keep tracking if there are more data or not

      final pdList = listOfDoc.map((document) {
        return PdfFileModel.fromMap(document.data() as Map<String, dynamic>);
      }).toList();

      _cahchedList = [..._cahchedList, ...pdList];

      print(
          "######################## cached list: ${_cahchedList.length} #######################");
    }
    _loadData = false;
    notifyListeners();
  }

//=================================================================================================================-----
  // call this function when pull down to refresh data
  Future<void> refresh(context) async {
    _cahchedList = [];
    startAfterDoc = null;
    await getpdfFiles(context);
  }

  // get more data when scroll down
  Future<void> loadMore(context) async {
    if (!_hasNext) return;
    await getpdfFiles(context);
  }
}
