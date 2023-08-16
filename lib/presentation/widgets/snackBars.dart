import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SnackBars {
  static void error(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: AppColors.danger,
      ),
    );
  }

  static void success(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successMessage),
        backgroundColor: AppColors.secondary,
      ),
    );
  }
}
