import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/insurance_types_enum.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/presentation/screens/payment/components/payment_method_modal.dart';

import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/router/routes.dart';

class InsuranceListItem extends StatelessWidget {
  const InsuranceListItem(this.insurance, {super.key});
  final InsuranceEntity insurance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [AppValues.boxShadow],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppValues.medium).r,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      SvgAssets.insurance,
                      width: AppSizes.s64.r,
                    ),
                    CustomSpacers.mediumLarge(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          insurance.insuranceType.name,
                          style: mediumSmallHeadlineStyle(),
                        ),
                        Text(
                          insurance.referenceNumber.toString(),
                          style: smallGrayBodyStyle(),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.calendar,
                              height: AppSizes.s20.r,
                              width: AppSizes.s20.r,
                            ),
                            CustomSpacers.extraSmall(),
                            Text(
                              insurance.startDate,
                              style: smallGrayBodyStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CustomSpacers.mediumLarge(),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      AppValues.medium.r * 2,
                  child: Wrap(
                    runSpacing: AppValues.medium,
                    spacing: AppValues.small,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.theVehicle.tr(),
                            style: extraSmallDarkGrayBodyStyle(),
                          ),
                          CustomSpacers.small(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: AppSizes.s28.r,
                                height: AppSizes.s28.r,
                                decoration: BoxDecoration(
                                    color: AppColors.lightest,
                                    borderRadius: BorderRadius.circular(
                                      AppValues.smallRadius,
                                    ),
                                    border:
                                        Border.all(color: AppColors.grayLight)),
                                child: CachedNetworkImage(
                                  imageUrl: insurance.vehicle.photo,
                                  width: AppSizes.s24.r,
                                  height: AppSizes.s24.r,
                                ),
                              ),
                              CustomSpacers.small(),
                              Text(
                                insurance.vehicle.alias,
                                style: extraSmallHeadlineStyle(),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.insuredName.tr(),
                            style: extraSmallDarkGrayBodyStyle(),
                          ),
                          CustomSpacers.small(),
                          Text(
                            '${insurance.vehicle.ownerFirstName} ${insurance.vehicle.ownerFatherName} ${insurance.vehicle.ownerLastName}',
                            style: extraSmallHeadlineStyle(),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.insuredBy.tr(),
                            style: extraSmallDarkGrayBodyStyle(),
                          ),
                          CustomSpacers.small(),
                          Text(
                            insurance.company.name,
                            style: extraSmallHeadlineStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomSpacers.medium(),
          const CustomDivider(),
          CustomSpacers.medium(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  CircleAvatar(
                    radius: AppSizes.s12.r,
                    backgroundColor:
                        insurance.insuranceTypeStatus.svgBackgroundColor,
                    child: SvgPicture.asset(
                      insurance.insuranceTypeStatus.svgPath,
                      width: AppSizes.s18.r,
                      height: AppSizes.s18.r,
                      colorFilter: ColorFilter.mode(
                          insurance.insuranceTypeStatus.svgColor,
                          BlendMode.srcIn),
                    ),
                  ),
                  CustomSpacers.small(),
                  Text(
                    insurance.insuranceTypeStatus.string.tr(),
                    style: extraSmallHeadlineStyle(),
                  )
                ]),
                getButton(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  String get textButton {
    switch (insurance.insuranceTypeStatus) {
      case InsuranceTypeStatus.underProcessing:
        return '';
      case InsuranceTypeStatus.issued:
        return AppStrings.viewTheDocument;
      case InsuranceTypeStatus.notPaid:
        return AppStrings.completeThePayment;
      case InsuranceTypeStatus.expired:
        return AppStrings.renewal;
    }
  }

  Widget getButton(BuildContext context) {
    void Function()? onPressed;
    if (insurance.insuranceTypeStatus.isExpired ||
        insurance.insuranceTypeStatus.isNotPaid) {
      onPressed = () {
        showModalBottomSheet(
          context: context,
          shape: AppValues.modalShape,
          isScrollControlled: true,
          builder: (context) => PaymentMethodModal(insurance.id),
        );
      };
    } else if (insurance.insuranceTypeStatus.isIssued) {
      onPressed = () {
        context.go(
            "${AppScreen.insuranceDocument.toPath}${insurance.referenceNumber}");
      };
    }
    return PrimaryButton(
      onPressed: onPressed,
      child: Text(textButton.tr()),
    );
  }
}
