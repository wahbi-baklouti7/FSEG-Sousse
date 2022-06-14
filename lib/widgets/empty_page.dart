import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.symmetric(
            horizontal: 0), // AppSize.symmetricPadding,
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  image,
                  height: 700,
                  width: 700,
                  cacheWidth: 700,
                  cacheHeight: 700,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
