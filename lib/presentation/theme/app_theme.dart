import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';

import 'app_colors.dart';

ThemeData appThemeData() => ThemeData(
      fontFamily: FontConstants.fontFamily,
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(primary: AppColors.primary, secondary: AppColors.secondary),
    );

class AppValues {
  // Decoration values:
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 32.0;

  // Decoration values - Default shadow theme:
  static const double shadowBlurRadius = 5;
  static const Offset shadowOffset = Offset(1, 1);
  static final BoxShadow boxShadow = BoxShadow(
      blurRadius: shadowBlurRadius,
      color: AppColors.blackShadow,
      offset: shadowOffset);
  // Animations:
  static const int pageTransitionAnimation = 500; // in milliseconds
  static const int calendarTransitionAnimation = 300; // in milliseconds
  static const int expandButtonAnimation = 300; // in milliseconds
}

class AppSizes {
  static const double s4 = 4;
  static const double s6 = 6;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s24 = 24;
  static const double s26 = 26;
  static const double s28 = 28;
  static const double s30 = 30;
  static const double s40 = 40;
  static const double s50 = 50;
  static const double s60 = 60;
  static const double s62 = 62;
  static const double s64 = 64;
  static const double s72 = 72;
  static const double s90 = 90;
  static const double s100 = 100;
  static const double s120 = 120;
  static const double s130 = 130;
  static const double s150 = 150;
  static const double s180 = 180;
  static const double s190 = 190;
  static const double s200 = 200;
  static const double s240 = 240;
  static const double s500 = 500;
}
