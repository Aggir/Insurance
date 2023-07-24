import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/assets_manager.dart';

import '../theme/app_theme.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({this.onTap, super.key});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        height: AppSizes.s48.r,
        width: AppSizes.s48.r,
        child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onTap ??
                () {
                  GoRouter.of(context).pop();
                },
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                Directionality.of(context) == TextDirection.rtl
                    ? SvgAssets.arrowRight
                    : SvgAssets.arrowLeft,
                height: AppSizes.s24.r,
                width: AppSizes.s24.r,
              ),
            )),
      ),
    );
  }
}
