import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';

class SelectedChoicCard extends StatelessWidget {
  const SelectedChoicCard({
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
          child:
              // SizedBox(
              //   width: 120,
              //   height: 120,
              //   child: Image.asset(selectedChoiceIcon,cacheHeight: 200,cacheWidth: 200,)
              // // Image(image: ResizeImage(AssetImage(selectedChoiceIcon), height: 200,width:200) )
              // ),
              Image.asset(
        selectedChoiceIcon,
        height: 150,
        width: 150,
        cacheHeight: 318,
        cacheWidth: 318,
      )),
    );
  }
}
