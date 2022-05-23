import 'package:flutter/cupertino.dart';
import 'package:fseg_sousse/services/auth/authentication.dart';
import 'package:fseg_sousse/widgets/alert.dart';
import 'package:fseg_sousse/widgets/custom_snakbar.dart';
import 'package:fseg_sousse/models/subject.dart';
import 'package:fseg_sousse/locator.dart';

import 'package:fseg_sousse/services/database/database.dart';

class AddSubjectViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = locator<DatabaseService>();

  final FireAuth _fireAuth = locator<FireAuth>();

  int? _selectedSemester;

  late Future<List<SubjectModel>> _fistSemesterSubjectList;
  late Future<List<SubjectModel>> _secondeSemesterList;

  Future<List<SubjectModel>> get firstSemesterSubjectList =>
      _fistSemesterSubjectList;
  Future<List<SubjectModel>> get secondeSemesterList => _secondeSemesterList;

  int? get getSelectedSemester => _selectedSemester;

  void setSelectedSemester(int val) {
    _selectedSemester = val;
    notifyListeners();
  }

  Future<bool> checkIfScubjectExist(
      {required int semester, String? subjectName}) async {
    final futureList = semester == 1
        ? await _fistSemesterSubjectList
        : await _secondeSemesterList;

    // iterate in the future list and compare subject with subject in list alreasy exist.

    for (var subject in futureList) {
      if (subject.name!.toLowerCase() == subjectName!.toLowerCase()) {
        // if subject exist return true.
        return true;
      }
    }
    // if subject not exist return false.
    return false;
  }

  void addSubject({context, String? subject}) async {
    // final _user = Provider.of<User?>(context, listen: false);
    final _user = _fireAuth.currentUser;
    bool isSubjectExist = await checkIfScubjectExist(
        semester: _selectedSemester!, subjectName: subject);

    if (!isSubjectExist) {
      String result = await _databaseService.addSubject(
          subjectName: subject,
          subjectModel: SubjectModel(
              name: subject, semester: _selectedSemester!, userId: _user!.uid));

      if (result == "success") {
        AppSnackBar.completeSnackBar(context, content: "Added Successefullye");
        if (_selectedSemester == 1) {
          getFirstSemesterSubjects(context);
        } else {
          getSecondeSemesterSubjects(context);
        }

        _selectedSemester = null;
        notifyListeners();
      }
    } else {
      AppAlert.normalAlertDialog(context,
          content: "Please check before add a new subject",
          title: "\"$subject\" already exists",
          onCancel: () => Navigator.pop(context));
    }
  }

  // return a list of subject name  of the first semester
  Future<void> getFirstSemesterSubjects(context) async {
    _fistSemesterSubjectList = _databaseService.getFirstSemesterSubjects();
  }

  // return list of subject name  of the seconde semester
  Future<void> getSecondeSemesterSubjects(context) async {
    _secondeSemesterList = _databaseService.getSecondSemesterSubjects();
  }

  Future<void> refreshFirstSemester(context) async {
    await getFirstSemesterSubjects(context);
    notifyListeners();
  }

  Future<void> refreshSecondeSemester(context) async {
    await getSecondeSemesterSubjects(context);
    notifyListeners();
  }
}
