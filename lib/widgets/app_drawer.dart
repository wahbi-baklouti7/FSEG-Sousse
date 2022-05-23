import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:fseg_sousse/constants/app_images.dart';
import 'package:fseg_sousse/viewModel/auth/sign_in_view_model.dart';
import 'package:fseg_sousse/views/auth/sign_in_view.dart';
import 'package:fseg_sousse/views/home/home_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                AppImages.universityLogo,
                width: 100,
                height: 120,
                cacheWidth: 900,
                cacheHeight: 900,
              )
            ])),
        // const Divider(height: 20, color: Colors.grey),
        const SizedBox(
          height: 8,
        ),
        ListTile(
          leading: const Icon(Icons.home, size: 40),
          title: Text('Home', style: Theme.of(context).textTheme.headline3),
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeView.id);
          },
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.exit_to_app, size: 40),
          title: Text('Sign out', style: Theme.of(context).textTheme.headline3),
          onTap: () {
            Navigator.of(context).pop();

            SignInViewModel().signOut(context);

            Navigator.pushNamedAndRemoveUntil(
                context, SignInScreen.id, (route) => false);
            print("signout fuction in app drawe ***********");
          },
        ),
      ]),
    );
  }
}
