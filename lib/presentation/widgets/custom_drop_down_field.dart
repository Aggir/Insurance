import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({
    Key? key,
    this.items,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.defaultValidator = true,
    this.hintText,
    this.onTap,
    this.initialValue,
    this.value,
    this.focusedStyleEnabled = true,
    this.hideErrorMessage = false,
    this.isLoading = false,
    this.selectedItemBuilder,
    this.disabledHint,
    this.disabledHintColor,
  }) : super(key: key);
  final List<DropdownMenuItem>? items;
  final void Function(dynamic)? onChanged;
  final void Function()? onTap;
  final String? Function(dynamic value)? validator;
  final bool defaultValidator;
  final bool enabled;
  final dynamic initialValue;
  final dynamic value;
  final String? hintText;
  final bool focusedStyleEnabled;
  final bool hideErrorMessage;
  final bool isLoading;
  final List<Widget> Function(BuildContext context)? selectedItemBuilder;
  final String? disabledHint;
  final Color? disabledHintColor;

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  dynamic selectedValue;
  bool _showError = false;

  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedValue = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDisabled =
        widget.disabledHintColor != null && (widget.items ?? []).isEmpty;
    if (widget.isLoading) {
      setState(() {
        selectedValue = null;
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // width: double.infinity,
          height: AppValues.textFieldHeight.r,
          child: DropdownButtonFormField(
            onTap: widget.onTap,
            validator: (value) => (widget.defaultValidator
                ? _defaultValidator(value, widget.validator)
                : null),
            icon: SvgPicture.asset(
              SvgAssets.chevronBottom,
              height: AppSizes.s22.r,
              width: AppSizes.s22.r,
            ),
            items: widget.isLoading ? [] : widget.items,
            value: widget.isLoading ? null : widget.value ?? selectedValue,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
              setState(() {
                selectedValue = value;
              });
            },
            disabledHint: widget.hintText != null
                ? Text(
                    widget.hintText!,
                    style: grayBodyStyle(),
                  )
                : null,
            selectedItemBuilder: widget.selectedItemBuilder,
            isExpanded: true,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              focusedBorder: widget.focusedStyleEnabled
                  ? null
                  : OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppValues.mediumRadius.r),
                      borderSide: BorderSide(color: AppColors.grayLight),
                    ),
              contentPadding: const EdgeInsets.symmetric(
                      vertical: AppValues.small, horizontal: AppValues.small)
                  .r,
              counterText: '',
              filled: isDisabled,
              fillColor:
                  isDisabled ? AppColors.grayLight.withOpacity(0.5) : null,
              hintText: widget.hintText ?? '',
              hintStyle: grayBodyStyle(),
            ),
          ),
        ),
        if (_showError)
          Padding(
            padding: const EdgeInsets.only(top: AppValues.extraSmall).r,
            child: Text(
              _errorMessage,
              style: textFieldErrorMessageStyle(),
            ),
          ),
        if (isDisabled)
          Padding(
            padding: const EdgeInsets.only(top: AppValues.extraSmall).r,
            child: Text(
              widget.disabledHint ?? Constants.empty,
              style: textFieldErrorMessageStyle()
                  .copyWith(color: widget.disabledHintColor),
            ),
          ),
      ],
    );
  }

  String? _defaultValidator(
      dynamic value, String? Function(dynamic value)? validator) {
    // check if there is a custom Validator
    if (validator != null) {
      String? errorMessage = validator(value);
      if (errorMessage != null) {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = true;
            _errorMessage = errorMessage;
          });
        }
        return '';
      } else {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = false;
            _errorMessage = '';
          });
        }
        return null;
      }
    } else {
      // use the default validator
      if (value == null || value.isEmpty) {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = true;
            _errorMessage = AppStrings.thisFieldIsRequired.tr();
          });
        }
        return '';
      } else {
        if (!widget.hideErrorMessage) {
          setState(() {
            _showError = false;
            _errorMessage = '';
          });
        }
        return null;
      }
    }
  }
}
