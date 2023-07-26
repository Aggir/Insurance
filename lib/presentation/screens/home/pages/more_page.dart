import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/secondary_button.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  void _profileWidgetFunction(BuildContext context) {
    context.go(Routes.profileRoute);
  }

  void _myPaymentsFunction(BuildContext context) {
    context.go(Routes.myPaymentsRoute);
  }

  void _termsAndConditionsFunction(BuildContext context) {
    context.go(Routes.termsAndConditionsRoute, extra: true);
  }

  void _settingsFunction(BuildContext context) {
    context.go(Routes.settingsRoute);
  }

  void _logoutFunction(BuildContext context) {
    context.go(Routes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
                  vertical: AppValues.large, horizontal: AppValues.medium)
              .r,
          child: Column(
            children: [
              _profileRowWidget(context),
              CustomSpacers.extraLarge(),
              Text(
                AppStrings.moreServices.tr(),
                style: darkGrayBodyStyle(),
              ),
              CustomSpacers.large(),
              _customListTile(
                context,
                imgPath: ImageAssets.myPaymentsListTile,
                title: AppStrings.myPayments.tr(),
                description: AppStrings.myPaymentsListTileDescription.tr(),
                onTap: _myPaymentsFunction,
              ),
              CustomSpacers.large(),
              _customListTile(
                context,
                imgPath: ImageAssets.termsAndConditions,
                title: AppStrings.termsAndConditions.tr(),
                description:
                    AppStrings.termsAndConditionsListTileDescription.tr(),
                onTap: _termsAndConditionsFunction,
              ),
              CustomSpacers.large(),
              _customListTile(
                context,
                imgPath: ImageAssets.settingsListTile,
                title: AppStrings.settings.tr(),
                description: AppStrings.settingsListTileDescription.tr(),
                onTap: _settingsFunction,
              ),
              CustomSpacers.extraLarge(),
              SecondaryButton.fullWidth(
                  onPressed: () => _logoutFunction(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        SvgAssets.logout,
                        height: AppSizes.s28.r,
                        width: AppSizes.s28.r,
                      ),
                      CustomSpacers.medium(),
                      Text(
                        AppStrings.logout.tr(),
                        style: smallHeadlineStyle()
                            .copyWith(color: AppColors.gray),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileRowWidget(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.lightest,
        boxShadow: [AppValues.boxShadow],
        borderRadius:
            BorderRadius.circular(AppValues.cardPageContainerRadius.r),
      ),
      child: Material(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _profileWidgetFunction(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                    vertical: AppValues.mediumSmall,
                    horizontal: AppValues.medium)
                .r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppSizes.s32.r,
                      backgroundColor: AppColors.transparent,
                      foregroundImage:
                          const AssetImage(ImageAssets.profilePicture),
                    ),
                    CustomSpacers.medium(),
                    SizedBox(
                      width: AppSizes.s200.r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DUMMY.fistName} ${DUMMY.middleName} ${DUMMY.lastName}',
                            style: smallHeadlineStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            DUMMY.email,
                            style: smallGrayBodyStyle(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  SvgAssets.chevronLeft,
                  height: AppSizes.s22.r,
                  width: AppSizes.s22.r,
                  colorFilter:
                      ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListTile(BuildContext context,
      {required String title,
      required String description,
      required String imgPath,
      void Function(BuildContext context)? onTap}) {
    return InkWell(
      onTap: onTap != null ? () => onTap(context) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightest,
                    borderRadius: BorderRadius.circular(
                      AppValues.cardPageContainerRadius.r,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    imgPath,
                    height: AppSizes.s100.r,
                    width: AppSizes.s84.r,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                CustomSpacers.medium(),
                SizedBox(
                  width: AppSizes.s170.r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: smallHeadlineStyle(),
                      ),
                      Text(
                        description,
                        style: smallGrayBodyStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                      vertical: AppValues.medium, horizontal: AppValues.small)
                  .r,
              decoration: BoxDecoration(
                  color: AppColors.lightest,
                  borderRadius:
                      BorderRadius.circular(AppValues.primaryButtonRadius),
                  border: Border.all(color: AppColors.grayLight)),
              child: SvgPicture.asset(
                SvgAssets.chevronLeft,
                height: AppSizes.s22.r,
                width: AppSizes.s22.r,
                colorFilter: ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
