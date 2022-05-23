import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/utilities/validator_utilities.dart';

import 'package:fseg_sousse/viewModel/auth/sign_in_view_model.dart';
import 'package:fseg_sousse/views/auth/reset_password_view.dart';
import 'package:fseg_sousse/views/auth/sign_up_view.dart';

import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
import 'package:fseg_sousse/widgets/default_text_form.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "Sign In";

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
    print(
        "**************************build sign in screen *********************************");
    final _signInViewModel =
        Provider.of<SignInViewModel>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 8.w),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 50,
                ),
                AppTextForm(
                  hintText: "Email",
                  lableText: "Email",
                  prefixIcon: Icons.email_outlined,
                  validator: (value) =>
                      ValidatorUtils.validateEmail(email: value!),
                  onSaved: (value) {
                    _email = value;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Consumer<SignInViewModel>(builder: (context, signVM, _) {
                  return AppTextForm(
                    obscureText: signVM.isObscure,
                    hintText: "Password",
                    lableText: "Password",
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(signVM.isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        signVM.toggle();
                      },
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your password";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                      return null;
                    },
                  );
                }),
                const SizedBox(height: 4),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPasswordScreen.id);
                    },
                    child: Text(
                      "Forget Password?",
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                const SizedBox(
                  height: 8,
                ),
                AppButton(
                  textButton: "Sign In",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _signInViewModel.signInWithEmail(context,
                          email: _email!, password: _password!);
                    }
                  },
                ),

                const SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(wordSpacing: 2),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.w900),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // google sing in button
                OutlinedButton(
                    style: ButtonStyle(
                      
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 10, color: Colors.red),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      _signInViewModel.signInWithGoogle(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox( height: 39, child: Image.asset(AppImages.googleLogo,cacheHeight: 120,cacheWidth: 120,)),
                        // const Image(
                        //   image: AssetImage(AppImages.googleLogo),
                        //   height: 39,
                        // ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text("Sign In With Google",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
