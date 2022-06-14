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
  String? _confirmEmail;
  String? _email;
  String? _password;
  String? _confirmPassword;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w), 
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
                  hintText: "Please Enter Your email address",
                  lableText: "Email Address",
                  prefixIcon: Icons.email_outlined,
                  validator: (value) =>ValidatorUtils.validateEmail(email: value!),
                    
                  onSaved: (value) {
                    _email = value;
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                AppTextForm(
                  hintText: " Please Enter Your Email Address",
                  lableText: "Confirm Email",
                  prefixIcon: Icons.email_outlined,
                  validator: (value) =>
                      ValidatorUtils.validateEmail(email: value!,confirmEmail: _email),
                  onSaved: (value) {
                    _confirmEmail = value;
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                AppTextForm(
                  obscureText: true,
                  hintText: "Please Enter Your Password",
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
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        if (_password == _confirmPassword) {
                          SignUpViewModel().signUpWithEmail(context,
                              email: _email!,
                              password: _password!,
                              );
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
