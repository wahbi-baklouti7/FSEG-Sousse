import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';

class SelectedChoiceCard extends StatelessWidget {
  const SelectedChoiceCard({
    Key? key,
    required this.selectedChoiceIcon,
  }) : super(key: key);

  final String selectedChoiceIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryColor,
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 1, offset: Offset(0, 0.4))
          ]),
      child: Center(
          child: Image.asset(
        selectedChoiceIcon,
        height: 150, 
        width: 150,
        cacheHeight: 250,
        cacheWidth: 250,
        filterQuality: FilterQuality.high,
      )),
    );
  }
}
