import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class CardPageContainer extends StatelessWidget {
  const CardPageContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                AppValues.cardPageContainerRadius.r,
              ),
            ),
          ),
          child: PageContentPadding(child: child),
        ),
      ),
    );
  }
}
