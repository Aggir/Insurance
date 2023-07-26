import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/dialog_service.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_button.dart';

class UnsubscribeDialog extends StatelessWidget {
  const UnsubscribeDialog({super.key});

  _createMyVehicleFunction(BuildContext context) {
    context.go(Routes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageAssets.unsubscribeDialog,
          width: AppSizes.s240.r,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.areYouSureYouWantToUnsubscribe.tr(),
          style: mediumHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.medium(),
        Text(
          AppStrings.unsubscribeConfirmationMessage.tr(),
          style: darkGrayBodyStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.extraLarge(),
        PrimaryButton.fullWidth(
          child: Text(AppStrings.deactivateAccount.tr()),
          onPressed: () => _createMyVehicleFunction(context),
          style: PrimaryButton.customStyle.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                return AppColors.danger;
              },
            ),
          ),
        ),
        CustomSpacers.medium(),
        SecondaryButton.fullWidth(
          child: Text(
            AppStrings.back.tr(),
            // style: grayBodyStyle(),
          ),
          onPressed: () => DialogService.dispose(),
        )
      ],
    );
  }
}
