import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight,
      height: 1.5);
}

//light textStyle

// TextStyle getThinStyle({double? fontSize, required Color color}) {
//   return _getTextStyle(fontSize ?? FontSize.s12, FontWeightManager.thin, color);
// }

//light textStyle

// TextStyle getExtraLightStyle({double? fontSize, required Color color}) {
//   return _getTextStyle(
//       fontSize ?? FontSize.s12, FontWeightManager.extraLight, color);
// }

//light textStyle

TextStyle getLightStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
      fontSize ?? FontSize.s12, FontWeightManager.light, color);
}

//regular textStyle

TextStyle getRegularStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
      fontSize ?? FontSize.s12, FontWeightManager.regular, color);
}

//medium textStyle

// TextStyle getMediumStyle({double? fontSize, required Color color}) {
//   return _getTextStyle(
//       fontSize ?? FontSize.s12, FontWeightManager.medium, color);
// }

//semiBold textStyle

// TextStyle getSemiBoldStyle({double? fontSize, required Color color}) {
//   return _getTextStyle(
//       fontSize ?? FontSize.s12, FontWeightManager.semiBold, color);
// }

//bold textStyle

TextStyle getBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? FontSize.s12, FontWeightManager.bold, color);
}

//extraBold textStyle

TextStyle getExtraBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(
      fontSize ?? FontSize.s12, FontWeightManager.extraBold, color);
}
