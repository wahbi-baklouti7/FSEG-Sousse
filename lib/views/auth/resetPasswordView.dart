import 'package:flutter/material.dart';
import 'package:fseg_sousse/components/components.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/helpers/validatorHelper.dart';
import 'package:fseg_sousse/viewModel/resetPasswordViewModel.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget{
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String? _email;
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // backwardsCompatibility: true,

          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
          
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              // padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     BackButton(
                  //       onPressed: () {},
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 0,
                  ),
                  Text("Reset Password",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.SECONDERY_COLOR,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  AppTextForm(
                      lableText: "Email Address",
                      hintText: "Enter Your Email Address",
                      onSaved: (value) {
                        _email=value;
                      },
                      validator: (value)=>ValidatorHelper.validateEmail(email: value!))
                      ,
                      
                  SizedBox(
                    height: 30,
                  ),
                  AppButton(textButton: "Send", onPressed: ()
                   {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        ResetPasswordViewModel.resetPassword(email: _email!);
                      }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
