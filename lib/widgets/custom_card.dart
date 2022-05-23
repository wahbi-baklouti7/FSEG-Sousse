import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final model;
  const AppCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 4), //const EdgeInsets.all(12),
          child: ListTile(
              title: Text(
                model.name,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ))),
    );
  }
}
