import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';

import 'app_colors.dart';
import 'font_manager.dart';

TextStyle largeHeadlineStyle() {
  return getBoldStyle(fontSize: FontSize.s20, color: AppColors.blackText);
}

TextStyle mediumHeadlineStyle() {
  return getBoldStyle(fontSize: FontSize.s18, color: AppColors.blackText);
}

TextStyle mediumSmallHeadlineStyle() {
  return getBoldStyle(fontSize: FontSize.s16, color: AppColors.blackText);
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

TextStyle primaryBodyStyle() {
  return getRegularStyle(fontSize: FontSize.s14, color: AppColors.primary);
}

TextStyle pressableTextStyle() {
  return getBoldStyle(fontSize: FontSize.s14, color: AppColors.primary);
}

TextStyle smallGrayBodyStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.gray);
}

TextStyle smallDarkGrayBodyStyle() {
  return getRegularStyle(fontSize: FontSize.s12, color: AppColors.darkGray);
}

TextStyle smallHeadlineStyle() {
  return getBoldStyle(color: AppColors.blackText, fontSize: FontSize.s14);
}

TextStyle extraSmallHeadlineStyle() {
  return getBoldStyle(color: AppColors.blackText, fontSize: FontSize.s12);
}

TextStyle smallDarkGrayHeadlineStyle() {
  return getBoldStyle(color: AppColors.darkGray, fontSize: FontSize.s14);
}

TextStyle extraSmallGrayBodyStyle() {
  return getRegularStyle(color: AppColors.gray, fontSize: FontSize.s10);
}

TextStyle textFieldErrorMessageStyle() {
  return getRegularStyle(color: AppColors.danger, fontSize: FontSize.s10);
}
