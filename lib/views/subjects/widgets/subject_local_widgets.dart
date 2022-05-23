// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/widgets/custom_card.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/widgets/empty_page.dart';
import 'package:fseg_sousse/models/subject.dart';
import 'package:fseg_sousse/utilities/global_data.dart';
import 'package:fseg_sousse/viewModel/subject/add_subject_view_model.dart';
import 'package:fseg_sousse/views/files/files_view.dart';
import 'package:provider/provider.dart';
import 'package:fseg_sousse/widgets/error_page.dart';

class FirstSemesterList extends StatefulWidget {
  const FirstSemesterList({Key? key}) : super(key: key);

  @override
  State<FirstSemesterList> createState() => _FirstSemesterListState();
}

class _FirstSemesterListState extends State<FirstSemesterList>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<AddSubjectViewModel>(context, listen: false)
        .getFirstSemesterSubjects(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print(
        "**************************build First Semester List *********************************");
    final provider = Provider.of<AddSubjectViewModel>(context, listen: false);
    super.build(context);

    return RefreshIndicator(
      onRefresh: () => provider.refreshFirstSemester(context),
      child: Selector<AddSubjectViewModel, Future<List<SubjectModel>>>(
        selector: (context, addSubject) => addSubject.firstSemesterSubjectList,
        builder: (context, firstSemster, _) {
          return FutureBuilder<List<SubjectModel>>(
              future: firstSemster,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const ErrorScreen();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return BuildSubjectsList(subjectList: snapshot.data);
              });
        },
      ),
    );
  }
}

class SecondeSemesterList extends StatefulWidget {
  const SecondeSemesterList({Key? key}) : super(key: key);

  @override
  State<SecondeSemesterList> createState() => _SecondeSemesterListState();
}

class _SecondeSemesterListState extends State<SecondeSemesterList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    Provider.of<AddSubjectViewModel>(context, listen: false)
        .getSecondeSemesterSubjects(context);
  }

  @override
  Widget build(BuildContext context) {
    print(
        "**************************build Seconde Semester List *********************************");
    final provider = Provider.of<AddSubjectViewModel>(context, listen: false);
    super.build(context);
    return RefreshIndicator(
      onRefresh: () => provider.refreshSecondeSemester(context),
      child: Selector<AddSubjectViewModel, Future<List<SubjectModel>>>(
        selector: (
          context,
          pro,
        ) =>
            pro.secondeSemesterList,
        builder: (context, secondSemester, _) {
          return FutureBuilder<List<SubjectModel>>(
              future: secondSemester,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const ErrorScreen();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return BuildSubjectsList(subjectList: snapshot.data);
              });
        },
      ),
    );
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
            message: "tap the '+' button to add subject",
            title: "No Subjects",
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
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

class SemesterField extends StatelessWidget {
  const SemesterField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Semester*", style: Theme.of(context).textTheme.headline2),
          ],
        ),
        Consumer<AddSubjectViewModel>(
          builder: (context, provider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 1,
                    groupValue: provider.getSelectedSemester,
                    onChanged: (int? val) {
                      provider.setSelectedSemester(val!);
                    }),
                const Text("Semester 1"),
                Radio(
                    value: 2,
                    groupValue: provider.getSelectedSemester,
                    onChanged: (int? value) {
                      provider.setSelectedSemester(value!);
                    }),
                const Text("Semester 2")
              ],
            );
          },
        ),
      ],
    );
  }
}
