import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/viewModel/auth/verifyEmailViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const id = "verify email";
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  Timer? timer;

  @override
  void didChangeDependencies() {
    final model = Provider.of<VerifyEmailViewModel>(context, listen: false);
    model.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      model.checkEmailVerification(context);
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "A verification link was sent to your address email",
            style: GoogleFonts.roboto(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer<VerifyEmailViewModel>(builder: (context, model, child) {
            return ElevatedButton.icon(
              label: Text("Resent Verification Link",
                  style: GoogleFonts.roboto(fontSize: 20)),
              onPressed:
                  model.canResend ? model.resendEmailLinkVerification : null,
              icon: const Icon(
                Icons.email,
                size: 30,
              ),
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all(const Size.fromHeight(50)),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.SECONDERY_COLOR)),
            );
          })
        ]),
      ),
    );
  }
}
