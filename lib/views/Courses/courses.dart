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
          padding: AppSize.symetricPadding,
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
                // const Spacer(flex: 1,),
                // const Spacer(),
                //  SizedBox(
                //   height: 300,
                //   width:300,
                //   child:Image.asset(AppImages.workingOn,cacheWidth: 800,cacheHeight: 800,filterQuality: FilterQuality.high,),
                //   Image(
                //   image:ResizeImage( AssetImage(AppImages.workingOn,),
                //   height: 600,
                //   width: 600,

                //   )

                // ),
                // ),
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    AppImages.workingOn,
                    // height: 800,
                    // width: 800,
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
                // Text("COMING SOON",
                //     style: Theme.of(context)
                //         .textTheme
                //         .headlineLarge!
                //         .copyWith(color: Colors.black)),
                // const SizedBox(height: 16),
                // Text(
                //   "This page under construction",
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context)
                //       .textTheme
                //       .headline3!
                //       .copyWith(color: Colors.black54),
                // ),
                // const Spacer(),
                // const Spacer(flex: 3,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
