import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import 'custom_indicator.dart';

AppBar stepsAppBarWidget({
  required Widget backButton,
  required int currentIndex,
  required int pageCount,
}) {
  return AppBar(
    backgroundColor: AppColors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    leading: backButton,
    actions: [
      CustomIndicator(
        currentPage: currentIndex.toDouble(),
        pageCount: pageCount,
      ),
    ],
  );
}
