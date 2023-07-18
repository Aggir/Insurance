import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import '../../../theme/app_theme.dart';

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
          padding: const EdgeInsets.only(bottom: AppValues.medium),
          height: AppSizes.s500,
          width: double.infinity,
          color: imgBackgroundColor,
          child: Image.asset(imgPath),
        ),
        _onboardingDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                header,
                style: darkGrayBodyStyle(),
              ).tr(),
              _contentDivider(),
              Text(
                description,
                style: headlineStyle(),
              ).tr(),
            ],
          ),
        )
      ],
    );
  }

  Widget _onboardingDivider() {
    return const SizedBox(height: AppValues.large, width: AppValues.large);
  }

  Widget _contentDivider() {
    return const SizedBox(height: AppValues.medium, width: AppValues.medium);
  }
}
