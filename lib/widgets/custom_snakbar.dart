import 'package:flutter/material.dart';

class AppSnackBar {
  static void normalSnackBar(context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                Text(content, //"Allowed maximum size is 5MB",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white)),
              ],
            ))));
  }

  static void errorSnackBar(context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                  width: 4,
                ),
                Text(content, //"Allowed maximum size is 5MB",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ))));
  }
}
