import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    this.onPressed,
    required this.child,
    this.isLoading = false,
    this.style,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool isLoading;
  static final customStyle = ElevatedButton.styleFrom(
    textStyle: smallHeadlineStyle(),
    minimumSize: AppValues.buttonMinSize,
    disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
    disabledForegroundColor: AppColors.whiteText,
    padding: const EdgeInsets.all(AppValues.mediumSmall).r,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ?? customStyle,
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? SizedBox(
              height: AppSizes.s25.r,
              width: AppSizes.s25.r,
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            )
          : child,
    );
  }

  static Widget fullWidth(
      {void Function()? onPressed,
      required Widget child,
      ButtonStyle? style,
      bool isLoading = false}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: style ?? customStyle,
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? SizedBox(
                height: AppSizes.s25.r,
                width: AppSizes.s25.r,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
            : child,
      ),
    );
  }
}
