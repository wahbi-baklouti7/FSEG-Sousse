import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_size.dart';

class EmptyScreen extends StatelessWidget {
  final String image;
  final String message;
  final String title;

  const EmptyScreen(
      {Key? key,
      required this.image,
      required this.message,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 0),// AppSize.symetricPadding,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              // const Spacer(
              //   flex: 1,
              // ),

              // SizedBox(
              //     height: 300,
              //     width: 300,
              //     child:
              //         // Image.asset(
              //         //   image,
              //         //   fit: BoxFit.cover,

              //         //   cacheHeight: 1000,
              //         //   cacheWidth: 1000,
              //         // )
              //         Image.asset(
              //       image,
              //       cacheHeight: 800,
              //       cacheWidth: 800,
              //     )

              //     ),
              Expanded(
                flex: 3,
                child: 
                        Image.asset(
                    image,
                    height: 700,
                    width: 700,
                    cacheWidth: 700,
                    cacheHeight: 700,
                    filterQuality: FilterQuality.high,
                // Image(
                //   filterQuality: FilterQuality.high,

                //   width: 800, height: 800,
                //   image:
                //       ResizeImage(AssetImage(image), height: 800, width: 800),
                // ),
              ),
              ),
// const SizedBox(height: 8),

              Expanded(
                // flex: 1,
                child: Column(children: [
                  Text(title, style: Theme.of(context).textTheme.headline1),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black54),
                    ),
                  ),
                ]),
              ),
              // Text(title, style: Theme.of(context).textTheme.headline1),
              // const SizedBox(height: 8),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 0),
              //   child: Text(
              //     message,
              //     textAlign: TextAlign.center,
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyText1!
              //         .copyWith(color: Colors.black54),
              //   ),
              // ),

              // const Spacer(
              //   flex: 5,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
