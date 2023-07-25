import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/app_strings.dart';
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
        AppStrings.myPayments.tr(),
        style: smallHeadlineStyle(),
      ),
      leading: CustomBackButton(
        onTap: backButton,
      ),
    );
  }
}
