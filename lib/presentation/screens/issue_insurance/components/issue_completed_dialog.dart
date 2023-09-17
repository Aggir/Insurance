import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/domain/data_classes/my_insurances_page_parameters.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/dialog_service.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_button.dart';

class IssueCompletedDialog extends StatelessWidget {
  const IssueCompletedDialog({super.key});

  _myInsurancesFunction(BuildContext context) {
    context.go(AppScreen.myInsurances.toPath,
        extra: const MyInsurancesPageParameters(pageIndex: 2));
    DialogService.dispose();
  }

  _homeScreenFunction(BuildContext context) {
    context.go(AppScreen.home.toPath);
    DialogService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageAssets.onboardingThree,
          width: AppSizes.s240.r,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.theInsurancePolicyHasBeenIssued.tr(),
          style: mediumHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.theInsurancePolicyHasBeenIssuedDescription.tr(),
          style: darkGrayBodyStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.extraLarge(),
        PrimaryButton.fullWidth(
          child: Text(AppStrings.myInsurances.tr()),
          onPressed: () => _myInsurancesFunction(context),
        ),
        CustomSpacers.medium(),
        SecondaryButton.fullWidth(
          child: Text(
            AppStrings.iWillPayLater.tr(),
            // style: grayBodyStyle(),
          ),
          onPressed: () => _homeScreenFunction(context),
        )
      ],
    );
  }
}
