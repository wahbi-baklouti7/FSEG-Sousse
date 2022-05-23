import 'package:cloud_firestore/cloud_firestore.dart';

class PdfFileModel{

  String? id;
  String? name;
  String? userUid;
  String? fileUrl;
  Timestamp? addedTime;   

  PdfFileModel({this.name,this.userUid,this.fileUrl,this.addedTime,this.id});


   factory PdfFileModel.fromMap(Map<String,dynamic> map){
    return PdfFileModel(
      id:map["id"],
      name:map["name"],
    userUid:map["userUid"],
    fileUrl:map["fileUrl"],
    addedTime:map["addedTime"],
    );

  }

  Map<String,dynamic> toMap(){
    return{
        "id":id,
        "name":name,
        "userUid":userUid,
        "fileUrl":fileUrl,
        "addedTime":addedTime

    };
  }
}