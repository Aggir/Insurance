import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/screens/settings/components/unsubscribe_dialog.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  void _changePasswordFunction(BuildContext context) {}

  void _unsubscribeFunction(BuildContext context) {
    DialogService.load(context, content: const UnsubscribeDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        title: AppStrings.settings.tr(),
        backButton: () => context.go(Routes.moreRoute),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(
                  vertical: AppValues.large, horizontal: AppValues.medium)
              .r,
          children: [
            _settingListTile(
              imgPath: ImageAssets.newPassword,
              title: AppStrings.changePassword.tr(),
              onTap: () => _changePasswordFunction(context),
            ),
            CustomSpacers.medium(),
            _settingListTile(
              imgPath: ImageAssets.unsubscribe,
              title: AppStrings.unsubscribeFormTheApp.tr(),
              onTap: () => _unsubscribeFunction(context),
            ),
          ]),
    );
  }

  Widget _settingListTile(
      {required String imgPath,
      required String title,
      void Function()? onTap}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
            BorderRadius.circular(AppValues.cardPageContainerRadius.r),
        boxShadow: [AppValues.boxShadow],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppValues.medium).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(AppValues.small.r),
                      ),
                      child: Image.asset(
                        imgPath,
                        height: AppSizes.s40.r,
                        width: AppSizes.s40.r,
                      ),
                    ),
                    CustomSpacers.mediumLarge(),
                    Text(
                      title,
                      style: smallHeadlineStyle(),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  SvgAssets.chevronLeft,
                  colorFilter:
                      ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
