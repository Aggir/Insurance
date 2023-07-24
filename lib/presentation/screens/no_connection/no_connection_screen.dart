import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  void _tryAgain() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(AppValues.extraLarge).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImageAssets.noConnection, width: AppSizes.s330.r),
                CustomSpacers.large(),
                Column(children: [
                  Text(AppStrings.checkInternetConnection.tr(),
                      style: mediumHeadlineStyle()),
                  CustomSpacers.medium(),
                  Text(AppStrings.checkInternetConnectionDescription.tr(),
                      style: grayBodyStyle())
                ]),
                CustomSpacers.large(),
                PrimaryButton.fullWidth(
                  child: Text(AppStrings.tryAgain.tr()),
                  onPressed: _tryAgain,
                )
              ],
            )),
      ),
    );
  }
}
