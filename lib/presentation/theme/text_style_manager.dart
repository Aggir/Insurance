import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';

import 'app_colors.dart';
import 'font_manager.dart';

TextStyle headlineStyle() {
  return getBoldStyle(fontSize: FontSize.s20, color: AppColors.blackText);
}

TextStyle bodyStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.blackText);
}

TextStyle darkGrayBodyStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.darkGrayText);
}

TextStyle grayBodyStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.gray);
}

TextStyle textButtonStyle() {
  return getBoldStyle(fontSize: FontSize.s14, color: AppColors.primary);
}

TextStyle pressableTextStyle() {
  return getBoldStyle(fontSize: FontSize.s14, color: AppColors.primary);
}
