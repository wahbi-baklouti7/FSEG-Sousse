import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/viewModel/auth/verify_email_view_model.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
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

    if (mounted) {
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        model.checkEmailVerification(context);
      });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "**************************build verify email screen *********************************");
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Padding(
        padding: AppSize.horizontalPadding,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "A verification link was sent to your address email",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          Consumer<VerifyEmailViewModel>(builder: (context, model, child) {
            return AppIconButton(
              onPressed:
                  model.canResend ? model.resendEmailLinkVerification : null,
              textButton: "Resent  Link",
              icon: Icons.email,
            );
          })
        ]),
      ),
    );
  }
}
