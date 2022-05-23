// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  List<Tab> tabTitle;
  List<Widget> tabView;
  MyTabBar({Key? key, required this.tabTitle, required this.tabView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(tabs: tabTitle),
          Expanded(
            child: TabBarView(children: tabView),
          )
        ],
      ),
    );
  }
}
