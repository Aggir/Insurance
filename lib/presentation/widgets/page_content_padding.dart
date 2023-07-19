import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PageContentPadding extends StatelessWidget {
  const PageContentPadding({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          top: AppValues.extraLarge,
          left: AppValues.large,
          right: AppValues.large,
          bottom: AppValues.large + AppValues.large / 3,
        ),
        child: child);
  }
}
