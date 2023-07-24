import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';

class CustomSpacers {
  static Widget large() {
    return SizedBox(
      height: AppValues.large.r,
      width: AppValues.large.r,
    );
  }

  static Widget extraLarge() {
    return SizedBox(
      height: (AppValues.large + AppValues.medium).r,
      width: (AppValues.large + AppValues.medium).r,
    );
  }

  static Widget mediumLarge() {
    return SizedBox(
      height: (AppValues.medium + AppValues.small).r,
      width: (AppValues.medium + AppValues.small).r,
    );
  }

  static Widget medium() {
    return SizedBox(
      height: AppValues.medium.r,
      width: AppValues.medium.r,
    );
  }

  static Widget small() {
    return SizedBox(
      height: AppValues.small.r,
      width: AppValues.small.r,
    );
  }

  static Widget extraSmall() {
    return SizedBox(
      height: (AppValues.small / 2).r,
      width: (AppValues.small / 2).r,
    );
  }
}
