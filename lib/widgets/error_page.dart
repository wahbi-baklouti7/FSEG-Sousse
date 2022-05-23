import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/widgets/buttons.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 0),// AppSize.symetricPadding, // const EdgeInsets.all(4.0),
        child: Center(
          child: Column(
            children: [
              // const Spacer(
              //   flex: 1,
              // ),

              Expanded(
                flex: 2,
                child: Image.asset(
                  AppImages.error,
                  cacheHeight: 700,
                  cacheWidth: 700,
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    Text("Error!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black)),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        "Something went wrong",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                        textButton: "Go Back",
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              )
              // Text("Error!",
              //     style: Theme.of(context)
              //         .textTheme
              //         .headlineLarge!
              //         .copyWith(color: Colors.black)),
              // const SizedBox(height: 8),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 0),
              //   child: Text(
              //     "Something went wrong",
              //     textAlign: TextAlign.center,
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyText1!
              //         .copyWith(color: Colors.black87),
              //   ),
              // ),
              // const SizedBox(height: 32),

              // AppButton(
              //     textButton: "Go Back",
              //     onPressed: () {
              //       Navigator.pop(context);
              //     }),
              // const Spacer(flex: 4),
              // const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
