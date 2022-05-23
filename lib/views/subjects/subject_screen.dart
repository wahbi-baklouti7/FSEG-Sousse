import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/views/subjects/add_subject.dart';
import 'package:fseg_sousse/views/subjects/widgets/subject_local_widgets.dart';
import 'package:fseg_sousse/widgets/app_drawer.dart';

class SubjectScreen extends StatelessWidget {
  static const String id = "Subjects";
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "**************************build subject view *********************************");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddSubject.id);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 32,
                  ))
            ],
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text("Subjects"),
            bottom: const TabBar(
              tabs: [
                Tab(
                    child: Text(
                  "Semester 1",
                )),
                Tab(
                    child: Text(
                  "Semester 2",
                ))
              ],
            )),
        drawer: const AppDrawer(),
        body: Padding(
          padding: AppSize.symetricPadding,
          child: const TabBarView(
              children: [FirstSemesterList(), SecondeSemesterList()]),
        ),
      ),
    );
  }
}
