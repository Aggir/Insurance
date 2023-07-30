import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';
import 'custom_indicator.dart';

AppBar stepsAppBarWidget(
    {required Widget backButton,
    required int currentIndex,
    required int pageCount,
    String title = ""}) {
  return AppBar(
    backgroundColor: AppColors.transparent,
    title: Text(title, style: smallHeadlineStyle()),
    centerTitle: true,
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
