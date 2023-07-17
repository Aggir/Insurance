import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({this.isActive = false, super.key});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? AppSizes.s18 : AppSizes.s12,
      width: AppSizes.s6,
      decoration: BoxDecoration(
          color:
              isActive ? AppColors.primary : AppColors.primary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(40)),
    );
  }
}
