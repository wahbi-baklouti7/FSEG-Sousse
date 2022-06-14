import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? fullName;
  String? email;
  int? contribution;
  Timestamp? accountCreated;

  UserModel(
      {this.uid,
      this.fullName,
      this.email,
      this.contribution,
      this.accountCreated});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ,
      email:json["email"] ,
      fullName:json["fullName"] ,
      contribution: json["contribution"] ,
      accountCreated:json["accountCreated"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "fullName": fullName,
      "email": email,
      "contribution": contribution,
      "accountCreated": accountCreated
    };
  }
}
