import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/models/menuChoiceModel.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedCard extends StatelessWidget {
  final MenuChoiceModel choice;
  SelectedCard({required this.choice});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
              offset: Offset(-3, 3),
              spreadRadius: 0,
            )
          ]),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(choice.icon),
                height: 70,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                choice.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}