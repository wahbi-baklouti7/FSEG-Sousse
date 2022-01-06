import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';



class AppButton extends StatelessWidget {
  final String textButton;
  Function() onPressed;

  AppButton({required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.SECONDERY_COLOR,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: MaterialButton(
          minWidth: 100,
          child: Text(
            textButton,
            style: GoogleFonts.roboto(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
          ),
          onPressed: onPressed),
    );
  }
}


// Text Form Validation
class AppTextForm extends StatelessWidget {
  final String? lableText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;

  String? Function(String? value) validator;
  String? Function(String? value) onSaved;

  AppTextForm({
    required this.lableText,
    required this.hintText,
    required this.onSaved,
    this.obscureText = false,
    this.prefixIcon,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: lableText,
          fillColor: AppColors.WHITE,
          filled: true,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 4)),
          hintText: hintText),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
