import 'package:flutter/material.dart';
import 'package:fseg_sousse/components/components.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/helpers/validatorHelper.dart';

import 'package:fseg_sousse/viewModel/signInViewModel.dart';
import 'package:fseg_sousse/views/auth/resetPasswordView.dart';
import 'package:fseg_sousse/views/auth/signUpView.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:fseg_sousse/constants/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _email;
  String? _password;
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
              SizedBox(
                height: 100,
              ),
              Text("Sign In",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      color: AppColors.SECONDERY_COLOR,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 80,
              ),
              AppTextForm(
                hintText: "Email",
                lableText: "Email",
                prefixIcon: Icons.email_outlined,
                validator: (value) =>
                    ValidatorHelper.validateEmail(email: value!),
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 16),
              AppTextForm(
                obscureText: true,
                hintText: "Password",
                lableText: "Password",
                prefixIcon: Icons.lock_outline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your password";
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 4),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
                  },
                  child: Text("Forget Password?",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ))),
              SizedBox(
                height: 8,
              ),
              AppButton(
                textButton: "Sign In",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                     SignInViewModel.signInWithEmail(
                        email: _email!, password: _password!);
                  }
                },
              ),
              SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.roboto(wordSpacing: 2, fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "Sign Up",
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
              OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(width: 10, color: Colors.red),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    SignInViewModel.signInWithGoogle(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(AppImages.GOOGLE_LOGO),
                        height: 49,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Sign In With Google",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
