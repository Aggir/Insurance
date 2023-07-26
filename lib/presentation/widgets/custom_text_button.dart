import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/text_style_manager.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          textStyle: pressableTextStyle(),
          disabledForegroundColor: AppColors.primary.withOpacity(0.3)),
      child: Text(
        text,
      ),
    );
  }
}
