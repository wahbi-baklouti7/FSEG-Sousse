// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/utilities/connectivity_status_enum.dart';
import 'package:fseg_sousse/widgets/buttons.dart';
import 'package:provider/provider.dart';
import 'package:fseg_sousse/constants/app_size.dart';

class NetworkSensitiveWidget extends StatefulWidget {
  Widget child;

  NetworkSensitiveWidget({Key? key, required this.child}) : super(key: key);
  @override
  _NetworkSensitiveWidgetState createState() => _NetworkSensitiveWidgetState();
}

class _NetworkSensitiveWidgetState extends State<NetworkSensitiveWidget> {
  @override
  Widget build(BuildContext context) {
    final networkStatus = Provider.of<ConnectivityStatus>(context);
    print("networkStatus: $networkStatus");
    if (networkStatus == ConnectivityStatus.online) {
      return widget.child;
    }
    return const NoInternetWidget();
  }
}

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),//AppSize.symetricPadding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Spacer(
            //   flex: 1,
            // ),
            
            
                 Expanded(
                   flex: 2,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 50),
                     child: Image.asset(
                      AppImages.noConnection,
                      height:700,
                      width:700,
                      cacheHeight: 700,
                      cacheWidth: 700,
                      filterQuality: FilterQuality.high,
                      
                                   ),
                   ),
                 ),
              Expanded(
                flex: 1,
                child: Column(
                  
                  children: [
                   Text("Ooops!",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black)),
                          const SizedBox(height: 8),
                          Padding(
                padding: AppSize.horizontalPadding,
                child: Text(
                  "There is no internet connection.\nPlease check your internet connection",
                  // "No internet connection found.\nCheck your connection or try again",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black87),
                ),
                          ),
                          const SizedBox(height: 24),
                          AppButton(
                  textButton: "BACK",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
                ],),
              )  
            // Text("Ooops!",
            //     style: Theme.of(context)
            //         .textTheme
            //         .headlineLarge!
            //         .copyWith(color: Colors.black)),
            // const SizedBox(height: 16),
            // Padding(
            //   padding: AppSize.horizontalPadding,
            //   child: Text(
            //     "There is no internet connection.\nPlease check your internet connection",
            //     // "No internet connection found.\nCheck your connection or try again",
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodyText1!
            //         .copyWith(color: Colors.black87),
            //   ),
            // ),
            // const SizedBox(height: 32),
            // AppButton(
            //     textButton: "BACK",
            //     onPressed: () {
            //       Navigator.pop(context);
            //     }),
            // const Spacer(
            //   flex: 3,
            // ),
          ],
        ),
      ),
    );
  }
}
