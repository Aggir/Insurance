import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_spacers.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    required this.imgPath,
    required this.imgBackgroundColor,
    required this.header,
    required this.description,
    super.key,
  });

  final String imgPath;
  final Color imgBackgroundColor;
  final String header;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: AppValues.medium).r,
          height: AppSizes.s500.r,
          width: double.infinity,
          color: imgBackgroundColor,
          child: Image.asset(imgPath),
        ),
        CustomSpacers.large(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                header,
                style: darkGrayBodyStyle(),
              ).tr(),
              CustomSpacers.medium(),
              Text(
                description,
                style: largeHeadlineStyle(),
              ).tr(),
            ],
          ),
        )
      ],
    );
  }
}
