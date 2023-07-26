import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

class MyVehiclesPage extends StatelessWidget {
  const MyVehiclesPage({super.key});

  _addVehicleFunction(context) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            AppStrings.myVehicles.tr(),
            style: smallHeadlineStyle(),
          ),
        ),
        body: emptyListState(context),
      ),
    );
  }

  Widget emptyListState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.large).r,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImageAssets.emptyList,
              height: AppSizes.s200.r,
              width: AppSizes.s200.r,
            ),
            CustomSpacers.large(),
            Text(
              AppStrings.youDoNotHaveVehicles.tr(),
              textAlign: TextAlign.center,
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              AppStrings.youDidNotAddAnyVehicle.tr(),
              textAlign: TextAlign.center,
              style: grayBodyStyle(),
            ),
            CustomSpacers.large(),
            PrimaryButton.fullWidth(
              child: Text(AppStrings.addVehicle.tr()),
              onPressed: () => _addVehicleFunction(context),
            )
          ],
        ),
      ),
    );
  }
}
