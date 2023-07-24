import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';

class PageContentPadding extends StatelessWidget {
  const PageContentPadding({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: AppValues.extraLarge.r,
          left: AppValues.large.r,
          right: AppValues.large.r,
          bottom: (AppValues.large + AppValues.large / 3).r,
        ),
        child: child);
  }
}
