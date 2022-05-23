import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';

class AppAlert {
  static void loadingIndicator(context, {String? content}) {
    Future.delayed(Duration.zero, () {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(content ?? ''),
                    ],
                  )),
            );
          });
    });
  }

  static Future confirmationDialog(context,
      {required VoidCallback onConfirm, required VoidCallback onCancel}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Text(
              'Delete File?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Are you sure you want to delete this file',
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: onCancel,
                  child: Text('cancel',
                      style: Theme.of(context).textTheme.bodyText2),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
              //  SizedBox(width: 4,),
              TextButton(
                  onPressed: onConfirm,
                  child: Text('Delete',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
            ],
          );
        });
  }

  static Future loadingProgressIndicator(context, {required Widget message}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: SizedBox(
                // decoration: BoxDecoration(borderRadius:BorderRadius.circular(5)),
                height: 100,
                child: (Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: CircularProgressIndicator()),
                      const SizedBox(
                        height: 16,
                      ),
                      message
                    ]))),
          );
        });
  }

  static Future normalAlertDialog(context,
      {required String content,
      required String title,
      required VoidCallback onCancel}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            content: Text(
              content,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: onCancel,
                  child: Text(
                    'cancel',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
            ],
          );
        });
  }
}
