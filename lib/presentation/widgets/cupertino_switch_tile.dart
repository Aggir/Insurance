import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../theme/app_colors.dart';
import '../theme/text_style_manager.dart';

class CupertinoSwitchTile extends StatelessWidget {
  const CupertinoSwitchTile({
    required this.onTap,
    required this.text,
    this.value = false,
    super.key,
  });
  final void Function(bool value) onTap;
  final String text;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppValues.small).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: darkGrayBodyStyle(),
            ),
            CupertinoSwitch(
              onChanged: (value) => onTap(value),
              value: value,
              activeColor: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
