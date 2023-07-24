import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_theme.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    this.onPressed,
    required this.child,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  static final _style = OutlinedButton.styleFrom(
    minimumSize: AppValues.buttonMinSize,
    disabledForegroundColor: AppColors.gray,
    foregroundColor: AppColors.gray,
    textStyle: grayBodyStyle(),
    padding: const EdgeInsets.all(AppValues.small + (AppValues.small / 2)),
    side: BorderSide(color: AppColors.grayLight, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppValues.primaryButtonRadius),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: onPressed == null ? 0.3 : 1,
        child: OutlinedButton(
          style: _style,
          onPressed: onPressed,
          child: child,
        ));
  }

  static Widget fullWidth({void Function()? onPressed, required Widget child}) {
    return Opacity(
      opacity: onPressed == null ? 0.3 : 1,
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: _style,
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
