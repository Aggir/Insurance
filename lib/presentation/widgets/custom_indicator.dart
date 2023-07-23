import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator(
      {required this.pageCount, required this.currentPage, super.key});
  final int pageCount;
  final double currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${currentPage.round() + 1} ${AppStrings.from.tr()} $pageCount',
          style: getBoldStyle(color: AppColors.darkGray),
        ),
        const SizedBox(width: AppValues.medium, height: AppValues.medium),
        ...List.generate(
          pageCount,
          (index) => Padding(
            padding: const EdgeInsets.all(AppValues.extraSmall),
            child: _dotContainer(currentPage, index),
          ),
        ),
      ],
    );
  }

  Widget _dotContainer(double currentPage, int index) {
    bool selectedDot = currentPage.round() == index;
    bool isFilled = currentPage >= index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: selectedDot ? AppSizes.s18 : AppSizes.s12,
      width: AppSizes.s6,
      decoration: BoxDecoration(
        color:
            isFilled ? AppColors.primary : AppColors.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}
