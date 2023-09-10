import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/vehicle.dart';
import 'package:insurance_app/presentation/blocs/my_vehicles/my_vehicles_cubit.dart';

import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../../app/assets_manager.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

class VehicleListItem extends StatelessWidget {
  const VehicleListItem(this.vehicle, {super.key});
  final VehicleEntity vehicle;

  void _secureNowButtonFunction(BuildContext context) {
    context.go(AppScreen.issueInsurance.toPath,
        extra: AppScreen.myVehicles.toPath);
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
                      SizedBox(
                        width: AppSizes.s180.r,
                        child: Text(
                          vehicle.alias.isEmpty
                              ? "${vehicle.brand.name} ${vehicle.model.name} - ${vehicle.makingYear}"
                              : vehicle.alias,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: mediumSmallHeadlineStyle(),
                        ),
                      ),
                      CustomSpacers.extraSmall(),
                      Text(
                        vehicle.licensePlate,
                        style: smallGrayBodyStyle(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  BlocConsumer<MyVehiclesCubit, MyVehiclesState>(
                    listenWhen: (previous, current) =>
                        previous.toggleIsVehicleHiddenStatus !=
                        current.toggleIsVehicleHiddenStatus,
                    listener: (context, state) {
                      if (state.toggleIsVehicleHiddenStatus.isFailure) {
                        SnackBars.error(
                            context, state.toggleIsVehicleHiddenErrorMessage!);
                      } else if (state.toggleIsVehicleHiddenStatus.isSuccess) {
                        SnackBars.success(
                            context,
                            (vehicle.isHidden
                                    ? AppStrings.showVehicleSuccessMessage
                                    : AppStrings.hideVehicleSuccessMessage)
                                .tr());
                      }
                    },
                    builder: (context, state) {
                      final bool isLoading =
                          state.toggleIsVehicleHiddenStatus.isLoading &&
                              state.selectedVehicleToHide == vehicle.id;
                      return Material(
                        color: AppColors.lightest,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: AppColors.grayLight,
                          ),
                          borderRadius:
                              BorderRadius.circular(AppValues.mediumRadius),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: state.toggleIsVehicleHiddenStatus.isLoading
                              ? null
                              : () => BlocProvider.of<MyVehiclesCubit>(context)
                                  .toggleIsVehicleHidden(vehicle.id),
                          child: Container(
                            width: AppSizes.s72.r,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppValues.mediumSmall,
                            ).r,
                            alignment: Alignment.center,
                            child: isLoading
                                ? SizedBox(
                                    height: AppSizes.s16.r,
                                    width: AppSizes.s16.r,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                      strokeWidth: 2.r,
                                    ),
                                  )
                                : Text(
                                    vehicle.isHidden
                                        ? AppStrings.showVehicle.tr()
                                        : AppStrings.hideVehicle.tr(),
                                    style: boldExtraSmallDarkGrayStyle(),
                                  ),
                            // child: SvgPicture.asset(
                            //   SvgAssets.chevronLeft,
                            //   height: AppSizes.s22.r,
                            //   width: AppSizes.s22.r,
                            //   colorFilter:
                            //       ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                            // ),
                          ),
                        ),
                      );
                    },
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
                        backgroundColor: vehicle.insurance == null
                            ? AppColors.primaryLight2
                            : AppColors.secondaryLight,
                        child: SvgPicture.asset(
                          vehicle.insurance == null
                              ? SvgAssets.xShield
                              : SvgAssets.shield,
                          width: AppSizes.s18.r,
                          height: AppSizes.s18.r,
                          colorFilter: ColorFilter.mode(
                              vehicle.insurance == null
                                  ? AppColors.danger
                                  : AppColors.secondary,
                              BlendMode.srcIn),
                        ),
                      ),
                      CustomSpacers.small(),
                      Text(
                        vehicle.insurance == null
                            ? AppStrings.notSecured.tr()
                            : AppStrings.secured.tr(),
                        style: extraSmallHeadlineStyle(),
                      ),
                    ],
                  ),
                  if (vehicle.insurance == null)
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
