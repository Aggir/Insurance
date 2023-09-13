import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SnackBars {
  static void error(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void success(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successMessage),
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
        content: Text(infoMessage),
        backgroundColor: AppColors.black.withOpacity(0.7),
      ),
    );
  }
}
