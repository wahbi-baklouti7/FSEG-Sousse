import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/widgets/app_drawer.dart';
import 'package:fseg_sousse/views/home/widgets/home_local_widget.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  static const String id = "Home";
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("home");
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Please confirm'),
                      content: const Text('Do you want to exit the app?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes'),
                        ),
                      ],
                    )) ??
            false;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(title: const Text("Home")),
        drawer: const AppDrawer(),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to ",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "FSEGS",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 35.sp),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Knowledge Increases By Sharing But Not By Saving.",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(wordSpacing: 1, letterSpacing: 0.5),
                      ),
                    ]),
              ),
              SizedBox(height: 5.h),
              const Expanded(
                child: HomeGridView(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
