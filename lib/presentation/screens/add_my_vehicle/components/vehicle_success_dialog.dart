import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../app_router.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/dialog_service.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_button.dart';

class VehicleSuccessDialog extends StatelessWidget {
  const VehicleSuccessDialog({super.key});
  _carsInsuranceFunction(BuildContext context) {
    context.go(Routes.carsInsuranceRoute);
    DialogService.dispose();
  }

  _homeScreenFunction(BuildContext context) {
    DialogService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageAssets.vehicleAddedSuccess,
          width: AppSizes.s240.r,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.youHaveSuccessfullyAddedYourVehicle.tr(),
          style: mediumHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.youCanNowGetInsuranceForYourVehicle.tr(),
          style: darkGrayBodyStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.extraLarge(),
        PrimaryButton.fullWidth(
          child: Text(AppStrings.carsInsurance.tr()),
          onPressed: () => _carsInsuranceFunction(context),
        ),
        CustomSpacers.medium(),
        SecondaryButton.fullWidth(
          child: Text(
            AppStrings.iWillCreateItLater.tr(),
            // style: grayBodyStyle(),
          ),
          onPressed: () => _homeScreenFunction(context),
        )
      ],
    );
  }
}
