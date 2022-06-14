import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/constants/app_size.dart';

class CoursesScreen extends StatelessWidget {
  static const String id = "Courses";
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSize.lrtpPadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    AppImages.workingOn,
                    height: 720,
                    width: 720,
                    cacheWidth: 700,
                    cacheHeight: 700,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("COMING SOON",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black)),
                      const SizedBox(height: 8),
                      Text(
                        "This page under construction",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
