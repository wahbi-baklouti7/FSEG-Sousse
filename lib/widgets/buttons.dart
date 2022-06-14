// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_images.dart';

class AppIconButton extends StatelessWidget {
  final String textButton;
  Function()? onPressed;
  IconData? icon;

  AppIconButton(
      {Key? key, required this.textButton, required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 39, color: Colors.white),
      label: Text(textButton,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        elevation: 1,
        onSurface: Colors.grey[600],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        fixedSize: const Size(200, 50),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String textButton;
  Function()? onPressed;

  AppButton({Key? key, required this.textButton, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(textButton,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        elevation: 1,
        onSurface: Colors.grey[600],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        fixedSize: const Size(200, 50),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget{


VoidCallback onPressed;
  GoogleButton({Key? key, required this.onPressed}) : super(key: key) ;

  @override 
  Widget build(BuildContext context){
    return OutlinedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 10, color: Colors.red),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: onPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 39,
                            child: Image.asset(
                              AppImages.googleLogo,
                              cacheHeight: 120,
                              cacheWidth: 120,
                            )),
                        const SizedBox(
                          width: 16,
                        ),
                        Text("Sign In With Google",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ));
  }
}
