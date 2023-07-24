import 'package:flutter/cupertino.dart';

import '../theme/app_theme.dart';

class CustomSpacers {
  static Widget large() {
    return const SizedBox(
      height: AppValues.large,
      width: AppValues.large,
    );
  }

  static Widget extraLarge() {
    return const SizedBox(
      height: AppValues.large + AppValues.medium,
      width: AppValues.large + AppValues.medium,
    );
  }

  static Widget mediumLarge() {
    return const SizedBox(
      height: AppValues.medium + AppValues.small,
      width: AppValues.medium + AppValues.small,
    );
  }

  static Widget medium() {
    return const SizedBox(
      height: AppValues.medium,
      width: AppValues.medium,
    );
  }

  static Widget small() {
    return const SizedBox(
      height: AppValues.small,
      width: AppValues.small,
    );
  }

  static Widget extraSmall() {
    return const SizedBox(
      height: AppValues.small / 2,
      width: AppValues.small / 2,
    );
  }
}
