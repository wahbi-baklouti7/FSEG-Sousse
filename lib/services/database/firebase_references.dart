import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/utilities/global_data.dart';

class FirestoreReference {
  final GlobalData _providerData = locator<GlobalData>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  CollectionReference get userCollection => _db.collection("users");

  DocumentReference get subjectDoc => _db
      .collection(_providerData.degree!)
      .doc(_providerData.degreeLevel!)
      .collection("Subjects")
      .doc(_providerData.subject);

  CollectionReference get subjectCollection => _db
      .collection(_providerData.degree!)
      .doc(_providerData.degreeLevel!)
      .collection("Subjects");

  CollectionReference get sectionCollection => _db
      .collection(_providerData.degree!)
      .doc(_providerData.degreeLevel!)
      .collection("Subjects")
      .doc(_providerData.subject)
      .collection(_providerData.section!);

  Reference get sectionStorageReference => _firebaseStorage.ref(
      "${_providerData.degree}/${_providerData.degreeLevel}/${_providerData.subject}/${_providerData.section}");
}
