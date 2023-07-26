import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_back_button.dart';

class CustomAppBar {
  static AppBar build(
      {required String title,
      void Function()? backButton,
      List<Widget>? actions}) {
    return AppBar(
      toolbarHeight: AppValues.appBarHeight.r,
      centerTitle: true,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      actions: actions,
      title: Text(
        title,
        style: smallHeadlineStyle(),
      ),
      leading: CustomBackButton(
        onTap: backButton,
      ),
    );
  }
}
