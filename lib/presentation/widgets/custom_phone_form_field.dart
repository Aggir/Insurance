import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'dart:ui' as ui;

import '../../app/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/text_style_manager.dart';
import 'custom_text_form_field.dart';

class CustomPhoneFormField extends StatefulWidget {
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
    this.label,
    this.focusNode,
    this.textInputAction,
    this.setCode,
    this.initialCodeValue,
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
  final String? label;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String? value)? setCode;
  final String? initialCodeValue;

  @override
  State<CustomPhoneFormField> createState() => _CustomPhoneFormFieldState();
}

class _CustomPhoneFormFieldState extends State<CustomPhoneFormField> {
  final FocusNode _focusNode = FocusNode();

  bool _showError = false;
  String _errorMessage = '';

  final flagContainerWidth = AppSizes.s120.r;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      errorStyle: const TextStyle(height: 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(AppValues.mediumRadius.r),
          left: Radius.zero,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppValues.mediumRadius.r)),
        borderSide: BorderSide(color: AppColors.grayLight),
      ),
      contentPadding: const EdgeInsets.symmetric(
              vertical: AppValues.small, horizontal: AppValues.small)
          .r,
      counterText: '',
      hintText: widget.hintText ?? '',
      hintStyle: grayBodyStyle(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          AnimatedContainer(
            height: _focusNode.hasFocus ? AppSizes.s30.r : 0,
            duration: const Duration(milliseconds: 150),
            child: _getLabelWidget(),
          ),
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  height: (AppValues.textFieldHeight - 1).r,
                  width: flagContainerWidth.r,
                  decoration: BoxDecoration(
                    color: AppColors.lightest,
                    border: Border.all(
                        color: _showError ? Colors.red : AppColors.grayLight),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(AppValues.mediumRadius.r),
                    ),
                  ),
                ),
                Container(
                  // height: AppValues.textFieldHeight.r,
                  width: flagContainerWidth.r,
                  decoration: BoxDecoration(
                    border:
                        Border(right: BorderSide(color: AppColors.lightest)),
                  ),
                  // Todo: get CountryCodePicker Value
                  child: CountryCodePicker(
                    initialSelection: widget.initialCodeValue ?? 'ly',
                    onInit: (value) {
                      if (widget.setCode != null) {
                        widget.setCode!(value?.dialCode);
                      }
                    },
                    onChanged: (value) {
                      if (widget.setCode != null) {
                        widget.setCode!(value.dialCode);
                      }
                    },
                    textStyle:
                        largeHeadlineStyle().copyWith(fontSize: FontSize.s14),
                    padding: EdgeInsets.zero,
                  ),
                )
              ]),
              Flexible(
                child: CustomTextFormField(
                  textInputAction: widget.textInputAction,
                  focusNode: widget.focusNode ?? _focusNode,
                  inputDecoration: inputDecoration,
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  hideErrorMessage: true,
                  validator: _validator,
                ),
              ),
            ],
          ),
        ),
        if (_showError)
          Padding(
            padding: const EdgeInsets.only(top: AppValues.extraSmall).r,
            child: Text(
              _errorMessage,
              style: textFieldErrorMessageStyle(),
            ),
          )
      ],
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = AppStrings.thisFieldIsRequired.tr();
      });

      return '';
    } else {
      setState(() {
        _showError = false;
        _errorMessage = '';
      });
      return null;
    }
  }

  Widget _getLabelWidget() {
    if (_focusNode.hasFocus) {
      return Text(
        widget.label!,
        style: smallDarkGrayBodyStyle(),
      );
    } else {
      return Container();
    }
  }
}
