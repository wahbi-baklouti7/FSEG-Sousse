import 'package:flutter/material.dart';

class AppSnackBar {
  static void normalSnackBar(BuildContext context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(8),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  )),
        )));
  }

  static void completeSnackBar(context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.green,
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(content,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white)),
              ],
            ))));
  }

  static void errorSnackBar(BuildContext context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(4),
        backgroundColor: Colors.red,
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.info_sharp,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(content,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white)),
              ],
            ))));
  }
}
