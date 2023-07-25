import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen(this.navigateFromSettings, {super.key});
  final bool navigateFromSettings;
  final String termsAndConditionsUpdateDate = '2023 - 7 - 12';

  void _acceptButtonFunction(BuildContext context) async {
    if (navigateFromSettings) {
      context.go(Routes.moreRoute);
    } else {
      context.push(Routes.loadingRoute);
      Future.delayed(const Duration(seconds: 2), () {
        context.pop();
        context.go(Routes.loginRoute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> termsAndConditionsList = [
      {
        'header': AppStrings.conditionOneHeader.tr(),
        'description': AppStrings.conditionOneDescription.tr()
      },
      {
        'header': AppStrings.conditionTwoHeader.tr(),
        'description': AppStrings.conditionTwoDescription.tr()
      },
      {
        'header': AppStrings.conditionThreeHeader.tr(),
        'description': AppStrings.conditionThreeDescription.tr()
      },
      {
        'header': AppStrings.conditionFourHeader.tr(),
        'description': AppStrings.conditionFourDescription.tr()
      },
      {
        'header': AppStrings.conditionFiveHeader.tr(),
        'description': AppStrings.conditionFiveDescription.tr()
      },
      {
        'header': AppStrings.conditionSixHeader.tr(),
        'description': AppStrings.conditionSixDescription.tr()
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
                  vertical: AppValues.large,
                  horizontal: AppValues.medium + AppValues.small)
              .r,
          child: Column(
            children: [
              _headerWidget(),
              CustomSpacers.large(),
              _contentWidget(termsAndConditionsList),
              const Divider(),
              CustomSpacers.medium(),
              PrimaryButton.fullWidth(
                onPressed: () => _acceptButtonFunction(context),
                child: Text(
                  (navigateFromSettings
                          ? AppStrings.backToThePreviousPage
                          : AppStrings.acceptTermsAndConditions)
                      .tr()
                      .toUpperCase(),
                ),
              ),
              CustomSpacers.medium(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Row(
      children: [
        Image.asset(
          ImageAssets.termsAndConditions,
          height: AppSizes.s68.r,
          width: AppSizes.s68.r,
        ),
        CustomSpacers.medium(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.termsAndConditions.tr(),
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.small(),
            Text(
              AppStrings.lastUpdate.tr() + termsAndConditionsUpdateDate,
              style: smallGrayBodyStyle(),
            ),
          ],
        )
      ],
    );
  }

  Widget _contentWidget(List<Map<String, String>> list) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.only(bottom: AppValues.extraSmall).r,
      itemBuilder: (context, index) => _conditionSection(
        index,
        list[index]['header'] ?? 'null',
        list[index]['description'] ?? 'null',
      ),
      itemCount: list.length,
      separatorBuilder: (context, index) => CustomSpacers.medium(),
    ));
  }

  Widget _conditionSection(int index, String header, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${index + 1}. $header',
          style: smallDarkGrayHeadlineStyle(),
        ),
        CustomSpacers.medium(),
        Text(
          description,
          style: smallDarkGrayBodyStyle(),
        ),
      ],
    );
  }
}
