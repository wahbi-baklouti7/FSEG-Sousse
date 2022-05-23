import 'package:flutter/material.dart';
import 'package:fseg_sousse/utilities/validator_utilities.dart';

import 'package:fseg_sousse/viewModel/auth/sign_up_view_model.dart';
import 'package:fseg_sousse/views/auth/sign_in_view.dart';

import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
import 'package:fseg_sousse/widgets/default_text_form.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "Sign Up";

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
    print(
        "**************************build sign Up screen *********************************");
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w), //ODO:fix this
            child: ListView(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text("Sign Up",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(
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
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                AppTextForm(
                  hintText: "Enter Your Email Address",
                  lableText: "Email",
                  prefixIcon: Icons.email_outlined,
                  validator: (value) =>
                      ValidatorUtils.validateEmail(email: value!),
                  onSaved: (value) {
                    _email = value;
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                AppTextForm(
                  obscureText: true,
                  hintText: "Enter Your Password",
                  lableText: "Password",
                  prefixIcon: Icons.lock_outline,
                  validator: (value) =>
                      ValidatorUtils.validatePassword(password: value!),
                  onSaved: (value) {
                    _password = value;
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                AppTextForm(
                  obscureText: true,
                  hintText: "Confirm Your Password",
                  lableText: "Confirm Password",
                  prefixIcon: Icons.lock_outline,
                  validator: (value) => ValidatorUtils.validatePassword(
                      password: value!, confirmPassword: _password),
                  onSaved: (value) {
                    _confirmPassword = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                AppButton(
                    textButton: "Sign Up",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_password == _confirmPassword) {
                          SignUpViewModel().signUpWithEmail(context,
                              email: _email!,
                              password: _password!,
                              fullName: _userName!);
                        }
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignInScreen.id);
                        },
                        child: Text(
                          "Sign In",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
