import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_size.dart';
import 'package:sizer/sizer.dart';
import 'package:fseg_sousse/constants/app_images.dart';

class BooksScreen extends StatelessWidget {
  static const String id = "Books";
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSize.lrtpPadding,
          child: Center(
            child: Column(
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
                // const Spacer(
                //   flex: 1,
                // ),

                // Image(image: const AssetImage(AppImages.workingOn),height: 50.h,),

                

                    
                    Expanded(
                      flex:3,
                      child: Image.asset(
                        
                        AppImages.workingOn,
                        height: 720,
                        width: 720,
                        cacheWidth: 720,
                        cacheHeight: 720,
                        filterQuality: FilterQuality.high,
                      ),
                    ),

                    Expanded(
                      flex:1,
                      child: Column(children:[
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
                      ]),
                    ),

                // Text("COMING SOON",
                //     style: Theme.of(context)
                //         .textTheme
                //         .headlineLarge!
                //         .copyWith(color: Colors.black)),
                // const SizedBox(height: 8),
                // Text(
                //   "This page under construction",
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context)
                //       .textTheme
                //       .headline3!
                //       .copyWith(color: Colors.black54),
                // ),
                // const Spacer(
                //   flex: 3,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
