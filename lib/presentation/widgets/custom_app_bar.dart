import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_back_button.dart';

import 'custom_indicator.dart';

class CustomAppBar {
  static Widget? _getTitle(
    Widget? customTitle,
    String? title,
  ) {
    if (customTitle != null) {
      return customTitle;
    } else if (title != null) {
      return Text(
        title,
        style: smallHeadlineStyle(),
      );
    } else {
      return null;
    }
  }

  static AppBar basic(
      {Widget? customTitle,
      String? title,
      void Function()? backButton,
      List<Widget>? actions,
      bool centerTitle = true,
      PreferredSize? bottom,
      Color? backButtonColor}) {
    return AppBar(
      toolbarHeight: AppValues.appBarHeight.r,
      centerTitle: centerTitle,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      bottom: bottom,
      actions: actions,
      title: _getTitle(customTitle, title),
      leading: CustomBackButton(
        onTap: backButton,
        color: backButtonColor,
      ),
    );
  }

  static AppBar steps({
    required Widget backButton,
    required int currentIndex,
    required int pageCount,
    Widget? customTitle,
    String? title,
    bool centerTitle = true,
  }) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      toolbarHeight: AppValues.appBarHeight.r,
      elevation: 0,
      centerTitle: centerTitle,
      leading: backButton,
      title: _getTitle(customTitle, title),
      actions: [
        CustomIndicator(
          currentPage: currentIndex.toDouble(),
          pageCount: pageCount,
        ),
      ],
    );
  }
}
