// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/widgets/custom_card.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/widgets/empty_page.dart';
import 'package:fseg_sousse/models/subject.dart';
import 'package:fseg_sousse/utilities/global_data.dart';
import 'package:fseg_sousse/viewModel/subject/subject_view_model.dart';
import 'package:fseg_sousse/views/files/files_view.dart';
import 'package:fseg_sousse/widgets/error_page.dart';

class FirstSemesterList extends StatefulWidget {
  const FirstSemesterList({Key? key}) : super(key: key);

  @override
  State<FirstSemesterList> createState() => _FirstSemesterListState();
}

class _FirstSemesterListState extends State<FirstSemesterList>
    with AutomaticKeepAliveClientMixin {
  final SubjectViewModel _subjectViewModel = SubjectViewModel();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("first semester list");
    return FutureBuilder<List<SubjectModel>>(
        future: _subjectViewModel.getFirstSemesterSubjects(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const ErrorScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return BuildSubjectsList(subjectList: snapshot.data);
        });
  }
}

class SecondeSemesterList extends StatefulWidget {
  const SecondeSemesterList({Key? key}) : super(key: key);

  @override
  State<SecondeSemesterList> createState() => _SecondeSemesterListState();
}

class _SecondeSemesterListState extends State<SecondeSemesterList>
    with AutomaticKeepAliveClientMixin {
  final SubjectViewModel _subjectViewModel = SubjectViewModel();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("second semester list");
    return FutureBuilder<List<SubjectModel>>(
        future: _subjectViewModel.getSecondeSemesterSubjects(),
        builder: (context, AsyncSnapshot snapshot) {
          
          if (snapshot.hasError) {
            return const ErrorScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return BuildSubjectsList(subjectList: snapshot.data);
        });
  }
}

class BuildSubjectsList extends StatelessWidget {
  List<SubjectModel> subjectList;

  BuildSubjectsList({
    required this.subjectList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return subjectList.isEmpty
        ? const EmptyScreen(
            image: AppImages.noSubject,
            message: "you don't have subjects this semester ",
            title: "No Subjects",
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: subjectList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    GlobalData.setSubject(subjectList[index].name);

                    Navigator.pushNamed(context, FileScreen.id);
                  },
                  child: AppCard(model: subjectList[index]));
            },
          );
  }
}
