import 'package:flutter/material.dart';
import 'package:fseg_sousse/widgets/degree_list.dart';
import 'package:fseg_sousse/widgets/selected_choice_card.dart';
import 'package:fseg_sousse/widgets/tap_bar.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/models/license.dart';
import 'package:fseg_sousse/models/master.dart';
import 'package:fseg_sousse/models/menu_choice_model.dart';

class ExamsScreen extends StatelessWidget {
  static const String id = "Exams";
  final MenuChoiceModel selectedMenuChoice;
  const ExamsScreen({Key? key, required this.selectedMenuChoice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: AppSize.horizontalPadding,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text(
                    selectedMenuChoice.title,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              const SizedBox(height: 10),
              SelectedChoiceCard(selectedChoiceIcon: selectedMenuChoice.icon),
              Expanded(
                child: MyTabBar(tabTitle: const [
                  Tab(
                    text: "Licences",
                  ),
                  Tab(
                    text: "Masters",
                  )
                ], tabView: [
                  LicenseList(licenses: licenseList),
                  MasterList(masterList: masterList)
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
