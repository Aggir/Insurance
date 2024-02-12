import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';

class SnackBars {
  static Text _snackBarText(String message) => Text(
        message,
        style: bodyStyle().copyWith(color: AppColors.white),
      );

  static void error(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _snackBarText(errorMessage),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void success(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _snackBarText(successMessage),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void info(BuildContext context, String infoMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // margin: const EdgeInsets.all(AppSizes.s16),
        behavior: SnackBarBehavior.floating,
        content: _snackBarText(infoMessage),
        backgroundColor: AppColors.black.withOpacity(0.7),
      ),
    );
  }
}
