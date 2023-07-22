import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class CustomFormFieldDatePicker extends StatelessWidget {
  const CustomFormFieldDatePicker({
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
    this.initialDate,
    this.firstDate,
    this.lastDate,
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
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(DateTime.now().year - 100),
        lastDate: lastDate ?? DateTime.now());
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-M-yyyy').format(pickedDate);

      controller?.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: validator,
      controller: controller,
      defaultValidator: defaultValidator,
      enabled: enabled,
      readOnly: readOnly,
      initialValue: initialValue,
      hintText: hintText,
      suffixIcon: showCalendarSuffixIcon
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                SvgAssets.calendar,
                height: AppSizes.s28,
                width: AppSizes.s28,
              ),
            )
          : suffixIcon,
      onTap: () => _showDatePicker(context),
      focusedStyleEnabled: focusedStyleEnabled,
    );
  }
}
