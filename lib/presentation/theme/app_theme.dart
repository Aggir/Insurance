import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';

import 'app_colors.dart';

ThemeData appThemeData() => ThemeData(
      fontFamily: FontConstants.fontFamily,
      scaffoldBackgroundColor: AppColors.white,
      dividerTheme: DividerThemeData(color: AppColors.grayLight, thickness: 1),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(primary: AppColors.primary, secondary: AppColors.secondary),
    );

class AppValues {
  // Padding and Margin
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double mediumSmall = 12.0;
  static const double medium = 16.0;
  static const double mediumLarge = 24.0;
  static const double large = 32.0;
  static const double extraLarge = 48.0;

  // Default Shadow
  static const double shadowBlurRadius = 4;
  static const Offset shadowOffset = Offset(0, 1);
  static final BoxShadow boxShadow = BoxShadow(
      blurRadius: shadowBlurRadius,
      color: AppColors.blackShadow,
      offset: shadowOffset);

  static final BoxShadow innerShadow = BoxShadow(
      blurRadius: 3,
      color: AppColors.black.withOpacity(0.04),
      offset: const Offset(0, -1));
  // Radius
  static const double mediumRadius = 10;
  static const double smallRadius = 5;
  static const double largeRadius = 15;
  // Sizes
  static Size buttonMinSize = Size(25.r, 50.r);
  // Dimensions
  static const double textFieldHeight = 50;
  static const double appBarHeight = 68;
}

class AppSizes {
  static const double s2 = 2;
  static const double s4 = 4;
  static const double s5 = 5;
  static const double s6 = 6;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s26 = 26;
  static const double s28 = 28;
  static const double s30 = 30;
  static const double s32 = 32;
  static const double s40 = 40;
  static const double s46 = 46;
  static const double s48 = 48;
  static const double s50 = 50;
  static const double s60 = 60;
  static const double s62 = 62;
  static const double s64 = 64;
  static const double s68 = 68;
  static const double s72 = 72;
  static const double s80 = 80;
  static const double s84 = 84;
  static const double s86 = 86;
  static const double s90 = 90;
  static const double s100 = 100;
  static const double s104 = 104;
  static const double s110 = 110;
  static const double s120 = 120;
  static const double s130 = 130;
  static const double s140 = 140;
  static const double s150 = 150;
  static const double s160 = 160;
  static const double s170 = 170;
  static const double s180 = 180;
  static const double s190 = 190;
  static const double s200 = 200;
  static const double s240 = 240;
  static const double s250 = 250;
  static const double s270 = 270;
  static const double s280 = 280;
  static const double s320 = 320;
  static const double s330 = 330;
  static const double s350 = 350;
  static const double s360 = 360;
  static const double s400 = 400;
  static const double s500 = 500;
}
