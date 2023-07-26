import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_back_button.dart';

class CustomAppBar {
  static AppBar build({required String title, void Function()? backButton}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.transparent,
      elevation: 0,
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
