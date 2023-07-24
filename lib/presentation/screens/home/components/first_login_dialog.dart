import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/secondary_button.dart';

class FirstLoginDialog extends StatelessWidget {
  const FirstLoginDialog({super.key});

  _createMyVehicleFunction(context) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageAssets.firstLogin,
          width: AppSizes.s240.r,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.youHaveCreatedYourAccountSuccessfully.tr(),
          style: mediumHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.toIssueCarInsuranceCreateYourVehicleFileFirst.tr(),
          style: darkGrayBodyStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.extraLarge(),
        PrimaryButton.fullWidth(
          child: Text(AppStrings.createMyVehicleFile.tr()),
          onPressed: () => _createMyVehicleFunction(context),
        ),
        CustomSpacers.medium(),
        SecondaryButton.fullWidth(
          child: Text(
            AppStrings.iWillCreateItLater.tr(),
            // style: grayBodyStyle(),
          ),
          onPressed: () => DialogService.dispose(),
        )
      ],
    );
  }
}
