import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// If you gonna add a custom `validator` you need to add `isErrorVisible` and `errorMessage` too
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.maxLength,
    this.defaultValidator = true,
    this.enabled = true,
    this.readOnly = false,
    this.initialValue,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isPassword = false,
    this.focusedStyleEnabled = true,
    this.onTap,
    this.inputDecoration,
    this.focusNode,
    this.hideErrorMessage = false,
    this.label,
  });
  final TextInputType keyboardType;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final bool defaultValidator;
  final bool enabled;
  final bool readOnly;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final void Function()? onTap;
  final bool focusedStyleEnabled;
  final InputDecoration? inputDecoration;
  final FocusNode? focusNode;
  final bool hideErrorMessage;
  final String? label;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _visible = false;
  bool _showError = false;
  String _errorMessage = '';
  final FocusNode _focusNode = FocusNode();

  Widget _iconContainer({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.small).r,
      child: FittedBox(fit: BoxFit.scaleDown, child: child),
    );
  }

  Widget _visibilityIconButton(String svgPath) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.extraSmall).r,
      child: Material(
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAlias,
        color: AppColors.transparent,
        child: InkWell(
          onTap: _toggleVisible,
          child: Padding(
            padding: const EdgeInsets.all(AppValues.extraSmall).r,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                svgPath,
                height: AppSizes.s28.r,
                width: AppSizes.s28.r,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _passwordSuffixIconButton => _visible
      ? _visibilityIconButton(SvgAssets.invisible)
      : _visibilityIconButton(SvgAssets.visible);

  void _toggleVisible() {
    setState(() {
      _visible = !_visible;
    });
  }

  Widget? get _suffixIcon => widget.isPassword
      ? _passwordSuffixIconButton
      : widget.suffixIcon != null
          ? _iconContainer(child: widget.suffixIcon!)
          : null;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      errorStyle: const TextStyle(height: 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.inputRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.inputRadius.r),
        borderSide: BorderSide(color: AppColors.grayLight),
      ),
      focusedBorder: widget.focusedStyleEnabled
          ? null
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.inputRadius.r),
              borderSide: BorderSide(color: AppColors.grayLight),
            ),
      contentPadding: const EdgeInsets.symmetric(
              vertical: AppValues.small, horizontal: AppValues.small)
          .r,
      counterText: '',
      suffixIcon: _suffixIcon,
      prefixIcon: widget.prefixIcon != null
          ? _iconContainer(child: widget.prefixIcon!)
          : null,
      hintText: widget.hintText ?? '',
      hintStyle: grayBodyStyle(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          AnimatedContainer(
            height: (_focusNode.hasFocus &&
                    widget.controller != null &&
                    widget.controller!.text.isNotEmpty)
                ? 30
                : 0,
            duration: const Duration(milliseconds: 150),
            child: Text(
              widget.label!,
              style: smallDarkGrayBodyStyle(),
            ),
          ),
        SizedBox(
          height: AppValues.textFieldHeight.r,
          child: TextFormField(
            focusNode: widget.focusNode ?? _focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            obscureText: widget.isPassword ? !_visible : false,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            onTap: widget.onTap,
            style: bodyStyle(),
            inputFormatters: getFormatters(),
            validator: (value) => (widget.defaultValidator
                ? _defaultValidator(value, widget.validator)
                : null),
            decoration: widget.inputDecoration ?? inputDecoration,
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

  List<TextInputFormatter> getFormatters() {
    switch (widget.keyboardType) {
      case TextInputType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case TextInputType.phone:
        return [FilteringTextInputFormatter.allow(RegExp(r'^\+?\d+'))];
      case TextInputType.name:
        return [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Zأ-ي]+| +|\s'))
        ];
      default:
        return [];
    }
  }
}
