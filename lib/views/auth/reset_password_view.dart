import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/utilities/validator_utilities.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
import 'package:fseg_sousse/viewModel/auth/reset_password_view_model.dart';
import 'package:fseg_sousse/widgets/default_text_form.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String id = "Reset Password";

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ResetPasswordViewModel _resetPasswordViewModel =
      ResetPasswordViewModel();
  String? _email;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(
        "**************************build resend password screen *********************************");
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              margin: AppSize.horizontalPadding,
              child: Column(
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
                  const Spacer(),
                  Text("Reset Password",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(
                    height: 100,
                  ),
                  AppTextForm(
                      lableText: "Email Address",
                      hintText: "Enter Your Email Address",
                      onSaved: (value) {
                        _email = value;
                        return null;
                      },
                      validator: (value) =>
                          ValidatorUtils.validateEmail(email: value!)),
                  const SizedBox(
                    height: 30,
                  ),
                  AppButton(
                      textButton: "Send",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _resetPasswordViewModel.resetPassword(context,
                              email: _email!);
                        }
                      }),
                  const Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
