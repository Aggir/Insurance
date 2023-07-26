import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({
    Key? key,
    this.controller,
    required this.entries,
    this.enabled = true,
    this.hintText,
    this.initialValue,
  }) : super(key: key);
  final TextEditingController? controller;
  final List<DropdownMenuEntry> entries;
  final bool enabled;
  final String? initialValue;
  final String? hintText;

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.text = widget.initialValue ?? widget.entries[0].label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return SizedBox(
        width: constrains.maxWidth,
        height: AppValues.textFieldHeight.r,
        child: DropdownMenu(
          controller: widget.controller,
          hintText: widget.hintText,
          textStyle: bodyStyle(),
          enabled: widget.enabled,
          dropdownMenuEntries: widget.entries,
          width: constrains.maxWidth,
          trailingIcon: SvgPicture.asset(SvgAssets.chevronBottom),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: grayBodyStyle(),
            contentPadding: const EdgeInsets.symmetric(
                    vertical: AppValues.small, horizontal: AppValues.small)
                .r,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.inputRadius.r),
              borderSide: BorderSide(color: AppColors.grayLight),
            ),
          ),
        ),
      );
    });
  }
}
