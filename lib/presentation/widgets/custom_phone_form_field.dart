import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/text_style_manager.dart';
import 'custom_text_form_field.dart';

class CustomPhoneFormField extends StatelessWidget {
  const CustomPhoneFormField({
    super.key,
    this.validator,
    this.controller,
    this.defaultValidator = true,
    this.enabled = true,
    this.readOnly = true,
    this.initialValue,
    this.hintText,
    this.suffixIcon,
    this.showCalendarSuffixIcon = true,
    this.focusedStyleEnabled = false,
  });
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final bool defaultValidator;
  final bool enabled;
  final bool readOnly;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final bool showCalendarSuffixIcon;
  final bool focusedStyleEnabled;

  @override
  Widget build(BuildContext context) {
    const flagContainerWidth = AppSizes.s120;
    // print();
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.inputRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(AppValues.inputRadius)),
        borderSide: BorderSide(color: AppColors.lightGray),
      ),
      counterText: '',
      hintText: hintText ?? '',
      hintStyle: grayBodyStyle(),
    );
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Row(
        children: [
          Stack(children: [
            Container(
              height: AppValues.textFieldHeight,
              width: flagContainerWidth,
              decoration: BoxDecoration(
                color: AppColors.lightPastelBlue,
                border: Border(
                  top: BorderSide(color: AppColors.lightGray),
                  left: BorderSide(color: AppColors.lightGray),
                  bottom: BorderSide(color: AppColors.lightGray),
                  right: BorderSide(color: AppColors.lightGray),
                ),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(AppValues.inputRadius),
                ),
              ),
              child: CountryCodePicker(
                initialSelection: 'ly',
                textStyle: headlineStyle().copyWith(fontSize: 14),
              ),
            ),
            Container(
              height: AppValues.textFieldHeight,
              width: flagContainerWidth,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: AppColors.white)),
              ),
            )
          ]),
          Flexible(
            child: CustomTextFormField(
              inputDecoration: inputDecoration,
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}
