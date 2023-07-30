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

class InstallmentDialog extends StatelessWidget {
  const InstallmentDialog(this.method, {super.key});
  final method;

  _okButtonFunction(BuildContext context) {
    // extra (paymentMethod id)
    context.go(Routes.paymentRoute, extra: method);
    DialogService.dispose();
  }

  _backButtonFunction(BuildContext context) {
    DialogService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageAssets.installment,
          width: AppSizes.s240.r,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.payInstallmentsViaTheBankingApplication.tr(),
          style: mediumHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.payInstallmentsViaTheBankingApplication.tr(),
          style: darkGrayBodyStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.extraLarge(),
        PrimaryButton.fullWidth(
          child: Text(AppStrings.ok.tr()),
          onPressed: () => _okButtonFunction(context),
        ),
        CustomSpacers.medium(),
        SecondaryButton.fullWidth(
          child: Text(
            AppStrings.back.tr(),
            // style: grayBodyStyle(),
          ),
          onPressed: () => _backButtonFunction(context),
        )
      ],
    );
  }
}
