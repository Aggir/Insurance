import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../theme/app_colors.dart';
import '../theme/text_style_manager.dart';

class CupertinoSwitchTile extends StatelessWidget {
  const CupertinoSwitchTile({
    required this.onTap,
    required this.text,
    super.key,
  });
  final void Function(BuildContext context) onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppValues.small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: darkGrayBodyStyle(),
            ),
            CupertinoSwitch(
              onChanged: (_) => onTap(context),
              value: true,
              activeColor: AppColors.green,
            ),
          ],
        ),
      ),
    );
  }
}
