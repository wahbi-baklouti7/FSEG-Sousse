import 'package:flutter/material.dart';
import 'package:fseg_sousse/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppThemeUtils {
  static ThemeData buildTheme() {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      scaffoldBackgroundColor: AppColors.white,
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.black)),
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: GoogleFonts.roboto(fontSize: 14.sp),
        labelStyle:
            GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.roboto(
            fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 2),
        centerTitle: true,
        elevation: 1,
        backgroundColor: AppColors.primaryColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
          // primarySwatch:,
          accentColor: AppColors.primaryColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
      )),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.roboto(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryColor,
        ),
        headline2: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        headline1: GoogleFonts.roboto(
            color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w700),
        headline3: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.black),
        bodyText1: GoogleFonts.roboto(fontSize: 12.sp, color: Colors.black),
      ),
    );
  }
}
