import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../../app/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

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
    this.isPassword = false,
    this.focusedStyleEnabled = true,
    this.onTap,
    this.inputDecoration,
    this.focusNode,
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
  final bool isPassword;
  final void Function()? onTap;
  final bool focusedStyleEnabled;
  final InputDecoration? inputDecoration;
  final FocusNode? focusNode;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _visible = false;

  Widget _suffixIconContainer({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.small),
      child: child,
    );
  }

  Widget _visibilityIconButton(String svgPath) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.small / 2),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.antiAlias,
        color: AppColors.transparent,
        child: InkWell(
          onTap: _toggleVisible,
          child: Padding(
            padding: const EdgeInsets.all(AppValues.small / 2),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                svgPath,
                height: AppSizes.s28,
                width: AppSizes.s28,
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
          ? _suffixIconContainer(child: widget.suffixIcon!)
          : null;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.inputRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppValues.inputRadius),
        borderSide: BorderSide(color: AppColors.lightGray),
      ),
      focusedBorder: widget.focusedStyleEnabled
          ? null
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.inputRadius),
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
      contentPadding: const EdgeInsets.symmetric(
          vertical: AppValues.small, horizontal: AppValues.small),
      counterText: '',
      suffixIcon: _suffixIcon,
      hintText: widget.hintText ?? '',
      hintStyle: grayBodyStyle(),
    );

    return SizedBox(
      height: AppValues.textFieldHeight,
      child: TextFormField(
        focusNode: widget.focusNode,
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
        validator: widget.validator ??
            (widget.defaultValidator ? _defaultValidator : null),
        decoration: widget.inputDecoration ?? inputDecoration,
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldIsRequired.tr();
    } else {
      return null;
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
