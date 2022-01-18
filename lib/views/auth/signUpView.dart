import 'package:flutter/material.dart';
import 'package:fseg_sousse/components/components.dart';
import 'package:fseg_sousse/components/toast.dart';
import 'package:fseg_sousse/helpers/validatorHelper.dart';


import 'package:fseg_sousse/viewModel/signUpViewModel.dart';
import 'package:fseg_sousse/views/auth/signInView.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fseg_sousse/constants/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  static const String id="Sign Up";
  
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _email;
  String? _userName;
  String? _password;
  String? _confirmPassword;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text("Sign Up",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      color: AppColors.SECONDERY_COLOR,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
              ),
              AppTextForm(
                hintText: "Enter Your Full Name",
                lableText: "Full Name",
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your full name";
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value;
                },
              ),
              SizedBox(height: 8),
              AppTextForm(
                hintText: "Enter Your Email Address",
                lableText: "Email",
                prefixIcon: Icons.email_outlined,
                validator: (value) =>
                    ValidatorHelper.validateEmail(email: value!),
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 8),
              AppTextForm(
                obscureText: true,
                hintText: "Enter Your Password",
                lableText: "Password",
                prefixIcon: Icons.lock_outline,
                validator: (value) =>
                    ValidatorHelper.validatePassword(password: value!),
                onSaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 8),
              AppTextForm(
                obscureText: true,
                hintText: "Confirm Your Password",
                lableText: "Confirm Password",
                prefixIcon: Icons.email_outlined,
                validator: (value) =>
                    ValidatorHelper.validatePassword(password: value!),
                onSaved: (value) {
                  _confirmPassword = value;
                },
              ),
              SizedBox(
                height: 24,
              ),
              AppButton(
                  textButton: "Sign Up",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (_password == _confirmPassword) {
                        SignUpViewModel.signUpWithEmail(
                            email: _email!, password: _password!);
                      } else {
                        ShowToast.toastError(content: "Password not match");
                        // print("Password not match");
                      }
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.roboto(wordSpacing: 2, fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.id);
                      },
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.roboto(
                            color: AppColors.SECONDERY_COLOR,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ))
                ],
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
