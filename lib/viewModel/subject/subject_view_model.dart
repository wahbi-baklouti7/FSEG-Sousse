import 'package:fseg_sousse/models/subject.dart';
import 'package:fseg_sousse/locator.dart';

import 'package:fseg_sousse/services/database/database.dart';

class SubjectViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();

  // return a list of subject name  of the first semester
  Future<List<SubjectModel>> getFirstSemesterSubjects() async {
    return _databaseService.getFirstSemesterSubjects();
  }

  // return list of subject name  of the seconde semester
  Future<List<SubjectModel>> getSecondeSemesterSubjects() async {
    return _databaseService.getSecondSemesterSubjects();
  }
}
