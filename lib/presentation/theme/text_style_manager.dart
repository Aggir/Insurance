import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';

import 'app_colors.dart';
import 'font_manager.dart';

TextStyle onboardingHeaderStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.darkGrayText);
}

TextStyle onboardingDescriptionStyle() {
  return getBoldStyle(fontSize: FontSize.s20, color: AppColors.blackText);
}

TextStyle textButtonStyle() {
  return getBoldStyle(fontSize: FontSize.s14, color: AppColors.primary);
}
