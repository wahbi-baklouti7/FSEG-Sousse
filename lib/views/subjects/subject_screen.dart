import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/locator.dart';
import 'package:fseg_sousse/utilities/global_data.dart';
import 'package:fseg_sousse/views/subjects/widgets/subject_local_widgets.dart';
import 'package:fseg_sousse/widgets/app_drawer.dart';

class SubjectScreen extends StatelessWidget {
  static const String id = "Subjects";

  
   SubjectScreen({Key? key,}) : super(key: key);

   final GlobalData _providerData = locator<GlobalData>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title:  Text(_providerData.section!),
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
          padding: AppSize.symmetricPadding,
          child: const TabBarView(
              children: [FirstSemesterList(), SecondeSemesterList()]),
        ),
      ),
    );
  }
}
