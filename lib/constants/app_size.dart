import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppSize {

  static EdgeInsetsGeometry get paddingAll => EdgeInsets.all(2.w);
  static EdgeInsetsGeometry get lrtpPadding =>
      EdgeInsets.fromLTRB(5.w, 3.h, 5.w, 0);
  static EdgeInsetsGeometry get symetricPadding =>
      EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h);


  /// horizontal padding with 6% of screen width
  static EdgeInsetsGeometry get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: 6.w);
}
