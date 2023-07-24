import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../../../../app/assets_manager.dart';

class IdentityVerificationImage extends StatelessWidget {
  const IdentityVerificationImage({required this.imagePath, super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SvgPicture.asset(
            SvgAssets.identityVerificationPassport,
            height: AppSizes.s104.r,
            width: AppSizes.s104.r,
          ),
        ),
        Center(
          child: SizedBox(
            height: AppSizes.s104.r,
            width: AppSizes.s104.r,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
                width: AppSizes.s86.r,
                height: AppSizes.s86.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
