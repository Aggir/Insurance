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
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/secondary_button.dart';

class PaymentCompletedDialog extends StatelessWidget {
  const PaymentCompletedDialog({super.key});

  _myInsurancesFunction(BuildContext context) {
    // Todo: make it dynamic
    context.go(Routes.myInsurancesRoute, extra: 1);
    DialogService.dispose();
  }

  _homeScreenFunction(BuildContext context) {
    context.go(Routes.homeRoute);
    DialogService.dispose();
  }

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
          AppStrings.paymentCompletedSuccessfully.tr(),
          style: mediumHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.paymentDialogMessage.tr(),
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
            AppStrings.homeScreen.tr(),
            // style: grayBodyStyle(),
          ),
          onPressed: () => _homeScreenFunction(context),
        )
      ],
    );
  }
}
