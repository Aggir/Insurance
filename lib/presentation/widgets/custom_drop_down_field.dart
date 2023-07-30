import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({
    Key? key,
    required this.items,
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
  }) : super(key: key);
  final List<DropdownMenuItem> items;
  final void Function(dynamic)? onChanged;
  final void Function()? onTap;
  final String? Function(String? value)? validator;
  final bool defaultValidator;
  final bool enabled;
  final dynamic initialValue;
  final dynamic value;
  final String? hintText;
  final bool focusedStyleEnabled;
  final bool hideErrorMessage;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
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
            items: widget.items,
            value: widget.value ?? selectedValue,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
              setState(() {
                selectedValue = value;
              });
            },
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
          )
      ],
    );
  }

  String? _defaultValidator(
      String? value, String? Function(String? value)? validator) {
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
