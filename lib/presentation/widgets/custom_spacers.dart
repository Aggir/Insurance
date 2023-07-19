import 'package:flutter/cupertino.dart';

import '../theme/app_theme.dart';

class CustomSpacers {
  static Widget large() {
    return const SizedBox(
      height: AppValues.large,
      width: AppValues.large,
    );
  }

  static Widget medium() {
    return const SizedBox(
      height: AppValues.medium,
      width: AppValues.medium,
    );
  }

  static Widget extraSmall() {
    return const SizedBox(
      height: AppValues.small / 2,
      width: AppValues.small / 2,
    );
  }
}
