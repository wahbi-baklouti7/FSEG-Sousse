import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fseg_sousse/models/pdf_file.dart';
import 'package:fseg_sousse/models/subject.dart';
import 'package:fseg_sousse/models/user.dart';
import 'package:fseg_sousse/services/database/firebase_references.dart';

class DatabaseService {
  final FirestoreReference _firestoreHelper = FirestoreReference();

  // store user info in database
  Future<void> createUser(UserModel user) async {
    try {
      await _firestoreHelper.userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  // add new subject to firestore database
  Future<String> addSubject(
      {String? subjectName, SubjectModel? subjectModel}) async {
    String message = "error";
    try {
      await _firestoreHelper.subjectCollection  
          .doc(subjectName)
          .set(subjectModel!.toJson());
      message = "success";
    } catch (e) {
      print(
           e.toString());
    }
    return message;
  }

  /// return a `Future` list of all first semester subject
  Future<List<SubjectModel>> getFirstSemesterSubjects({
    String? degree,
    String? degreeLevel,
  }) async {
    List<SubjectModel> list = [];
    try {
      QuerySnapshot _querySnapshot = await _firestoreHelper.subjectCollection
          .where("semester", isEqualTo: 1)
          .get();
      list = _querySnapshot.docs
          .map((e) => SubjectModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

    } catch (e) {
      print(e.toString());
    }

    return list;
  }

  /// return a `Future` list of all second semester subject
  Future<List<SubjectModel>> getSecondSemesterSubjects() async {
    List<SubjectModel> list = [];
    try {
      QuerySnapshot _querySnapshot = await _firestoreHelper.subjectCollection
          .where("semester", isEqualTo: 2)
          .get();

      list = _querySnapshot.docs
          .map((e) => SubjectModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    return list;
  }

  // upload picked file to database storage
  UploadTask? uploadFile({
    required File filePath,
    required String fileName,
  }) {
    Reference _ref = _firestoreHelper.sectionStorageReference.child(fileName);

    try {
      UploadTask uploadTask = _ref.putFile(filePath);
      return uploadTask;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // add the new Pdf file to firestore database
  Future<void> addFile({
    required PdfFileModel model,
  }) async {
    try {
      DocumentReference _docRef = _firestoreHelper.sectionCollection.doc();

      await _docRef.set(PdfFileModel(
        id: _docRef.id,
        name: model.name,
        fileUrl: model.fileUrl,
        addedTime: model.addedTime,
        userUid: model.userUid,
      ).toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  // get all pdf files
  Future<List<DocumentSnapshot>> getPdfFiles({
    DocumentSnapshot? startAfter,
  }) async {
    List<DocumentSnapshot> list = [];

    try {
      final _query = _firestoreHelper.sectionCollection
          .orderBy("addedTime", descending: true)
          .limit(10);

      if (startAfter == null) {
        final querySnapshot = await _query.get();
        list = querySnapshot.docs.map((document) {
          return document;
        }).toList();
      } else {
        final querySnapshot = await _query.startAfterDocument(startAfter).get();
        list = querySnapshot.docs.map((document) => document).toList();
      }
    } catch (e) {
      print(e.toString);
    }
    return list;
  }

  // delete file from database
  Future<void> deleteFile({required String fileId}) async {
    DocumentReference _docRef = _firestoreHelper.sectionCollection.doc(fileId);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.delete(_docRef);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // delete file from database storage
  Future<void> deleteFileFromStorage(String url) async {
    FirebaseStorage _fireStorage = FirebaseStorage.instance;

    try {
      await _fireStorage.refFromURL(url).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // update file data in firestore
  Future<void> updateFileDocument(
      {required PdfFileModel model, required String fileId}) async {
    DocumentReference _docRef = _firestoreHelper.sectionCollection.doc(fileId);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(
            _docRef,
            PdfFileModel(
              id: _docRef.id,
              name: model.name,
              fileUrl: model.fileUrl,
              addedTime: model.addedTime,
              userUid: model.userUid,
            ).toMap());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // update new file data in firebase storage
  UploadTask? updateFileOnStorage({
    required File filePath,
    required String fileName,
  }) {
    Reference _ref = _firestoreHelper.sectionStorageReference.child(fileName);

    try {
      UploadTask uploadTask = _ref.putFile(filePath);
      return uploadTask;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
