import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

import '../theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    this.onPressed,
    required this.child,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  static final _style = ElevatedButton.styleFrom(
    minimumSize: AppValues.buttonMinSize,
    disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
    disabledForegroundColor: AppColors.whiteText,
    padding: const EdgeInsets.all(AppValues.small + (AppValues.small / 2)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppValues.primaryButtonRadius),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _style,
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget fullWidth({void Function()? onPressed, required Widget child}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: _style,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
