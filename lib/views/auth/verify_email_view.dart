import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: AppSize.horizontalPadding,
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    AppImages.sendEmail,
                    height: 300,
                    width: 300,
                    cacheHeight: 700,
                    cacheWidth: 700,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Verify Your Email",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Check your email & click the link to activate your account",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Consumer<VerifyEmailViewModel>(
                          builder: (context, model, child) {
                        return AppIconButton(
                          onPressed: model.canResend
                              ? model.resendEmailLinkVerification
                              : null,
                          textButton: "Resent  Link",
                          icon: Icons.email,
                        );
                      })
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
