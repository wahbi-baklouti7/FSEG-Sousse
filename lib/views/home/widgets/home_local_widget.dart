import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/models/menu_choice_model.dart';
import 'package:fseg_sousse/utilities/global_data.dart';

class SelectedCard extends StatelessWidget {
  final MenuChoiceModel selectedChoice;
  const SelectedCard({Key? key, required this.selectedChoice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 400,
      child: Card(
        color: AppColors.primaryColor,
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(
                selectedChoice.icon,
                filterQuality: FilterQuality.high,
                cacheHeight: 150,
                cacheWidth: 150,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              selectedChoice.title,
              style: const TextStyle(
                  overflow: TextOverflow.clip,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ],
        )),
      ),
    );
  }
}

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: menuChoices.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              GlobalData.setSection(menuChoices[index].title);
              Navigator.pushNamed(context, menuChoices[index].title,
                  arguments: menuChoices[index]);
            },
            child: SelectedCard(
              selectedChoice: menuChoices[index],
            ),
          );
        });
  }
}
