// Text Form Validation
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';

class AppTextForm extends StatelessWidget {
  final String? lableText;
  final String? hintText;
  final IconData? prefixIcon;
  bool? obscureText;
  final Widget? suffixIcon;

  String? Function(String? value) validator;
  String? Function(String? value) onSaved;

  AppTextForm({
    Key? key,
    required this.lableText,
    required this.hintText,
    required this.onSaved,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          labelText: lableText,
          fillColor: AppColors.white,
          filled: true,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 4)),
          hintText: hintText),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
