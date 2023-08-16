import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/domain/entities/vehicle.dart';

import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/assets_manager.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

class VehicleListItem extends StatelessWidget {
  const VehicleListItem(this.vehicle, {super.key});
  final VehicleEntity vehicle;

  void _secureNowButtonFunction(BuildContext context) {
    context.go(AppScreen.issueInsurance.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [AppValues.boxShadow],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppValues.medium).r,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: AppSizes.s64.r,
                    height: AppSizes.s64.r,
                    decoration: BoxDecoration(
                      color: AppColors.lightest,
                      border: Border.all(color: AppColors.grayLight),
                      borderRadius:
                          BorderRadius.circular(AppValues.mediumRadius.r),
                    ),
                    padding: const EdgeInsets.all(AppValues.extraSmall).r,
                    child: CachedNetworkImage(imageUrl: vehicle.brand.icon),
                  ),
                  CustomSpacers.small(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.alias.isEmpty
                            ? "${vehicle.brand.name} ${vehicle.model.name} - ${vehicle.makingYear}"
                            : vehicle.alias,
                        style: mediumSmallHeadlineStyle(),
                      ),
                      CustomSpacers.extraSmall(),
                      Text(
                        vehicle.licensePlate,
                        style: smallGrayBodyStyle(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                            vertical: AppValues.medium,
                            horizontal: AppValues.small)
                        .r,
                    decoration: BoxDecoration(
                        color: AppColors.lightest,
                        borderRadius:
                            BorderRadius.circular(AppValues.mediumRadius),
                        border: Border.all(color: AppColors.grayLight)),
                    child: SvgPicture.asset(
                      SvgAssets.chevronLeft,
                      height: AppSizes.s22.r,
                      width: AppSizes.s22.r,
                      colorFilter:
                          ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
              CustomSpacers.medium(),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: AppValues.small.r,
                runSpacing: AppValues.small.r,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.vehicleType.tr(),
                        style: extraSmallDarkGrayBodyStyle(),
                      ),
                      Text(
                        vehicle.type.name,
                        style: extraSmallHeadlineStyle(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.usage.tr(),
                        style: extraSmallDarkGrayBodyStyle(),
                      ),
                      Text(
                        vehicle.ownershipType.name,
                        style: extraSmallHeadlineStyle(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.countryOfManufacture.tr(),
                        style: extraSmallDarkGrayBodyStyle(),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.grayLight, width: 0.5.r)),
                            child: CachedNetworkImage(
                              imageUrl: vehicle.country.icon,
                              width: AppSizes.s22.r,
                              height: AppSizes.s18.r,
                            ),
                          ),
                          CustomSpacers.small(),
                          Text(
                            vehicle.country.name,
                            style: extraSmallHeadlineStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.city.tr(),
                        style: extraSmallDarkGrayBodyStyle(),
                      ),
                      Text(
                        vehicle.city.name,
                        style: extraSmallHeadlineStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              CustomSpacers.medium(),
              const CustomDivider(),
              CustomSpacers.medium(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: AppSizes.s12.r,
                        backgroundColor: AppColors.primaryLight2,
                        child: SvgPicture.asset(
                          SvgAssets.xShield,
                          width: AppSizes.s18.r,
                          height: AppSizes.s18.r,
                          colorFilter: ColorFilter.mode(
                              AppColors.danger, BlendMode.srcIn),
                        ),
                      ),
                      CustomSpacers.small(),
                      Text(
                        'غير مأمنة',
                        style: extraSmallHeadlineStyle(),
                      ),
                    ],
                  ),
                  PrimaryButton(
                    onPressed: () => _secureNowButtonFunction(context),
                    child: Text(AppStrings.secureNow.tr()),
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
