import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

import '../theme/text_style_manager.dart';

class PressableText extends StatelessWidget {
  const PressableText({
    required this.text,
    required this.onTap,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.disabledTextColor,
    super.key,
  });
  final String text;
  final void Function()? onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? disabledTextColor;
  @override
  Widget build(BuildContext context) {
    bool isActive = onTap != null;
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: pressableTextStyle().copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: isActive
                ? textColor ?? AppColors.primary
                : disabledTextColor ?? AppColors.primary.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
