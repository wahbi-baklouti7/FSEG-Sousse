class SubjectModel {
  String? name;
  int semester;
  String? userId;

  SubjectModel(
      {required this.name, required this.semester, required this.userId});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
        name: json["name"] ,
        semester: json["semester"] ,
        userId: json["userId"] );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "semester": semester,
      "userId": userId,
    };
  }
}


