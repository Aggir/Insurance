import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/insurance_types_enum.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/screens/payment/components/payment_type_modal.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

class InsuranceListItem extends StatelessWidget {
  const InsuranceListItem(this.insurance, {super.key});
  final Insurance insurance;

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
                          insurance.insuranceType,
                          style: mediumSmallHeadlineStyle(),
                        ),
                        Text(
                          insurance.referenceNumber,
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
                              insurance.issuanceDate,
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
                                child: Image.asset(
                                  insurance.carBrandImgPath,
                                  width: AppSizes.s24.r,
                                  height: AppSizes.s24.r,
                                ),
                              ),
                              CustomSpacers.small(),
                              Text(
                                insurance.carBrand,
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
                            insurance.insuredName,
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
                            insurance.insuranceCompany,
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
                        insurance.insuranceStatus.svgBackgroundColor,
                    child: SvgPicture.asset(
                      insurance.insuranceStatus.svgPath,
                      width: AppSizes.s18.r,
                      height: AppSizes.s18.r,
                      colorFilter: ColorFilter.mode(
                          insurance.insuranceStatus.svgColor, BlendMode.srcIn),
                    ),
                  ),
                  CustomSpacers.small(),
                  Text(
                    insurance.insuranceStatus.string.tr(),
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
    switch (insurance.insuranceStatus) {
      case InsuranceStatus.underProcessing:
        return '';
      case InsuranceStatus.issued:
        return AppStrings.viewTheDocument;
      case InsuranceStatus.notPaid:
        return AppStrings.completeThePayment;
      case InsuranceStatus.expired:
        return AppStrings.renewal;
    }
  }

  Widget getButton(BuildContext context) {
    void Function()? onPressed;
    if (insurance.insuranceStatus.isExpired ||
        insurance.insuranceStatus.isNotPaid) {
      onPressed = () {
        showModalBottomSheet(
          context: context,
          shape: AppValues.modalShape,
          isScrollControlled: true,
          builder: (context) => const PaymentTypeModal(),
        );
      };
    } else if (insurance.insuranceStatus.isIssued) {
      onPressed = () {
        context
            .go("${Routes.insuranceDocumentRoute}${insurance.referenceNumber}");
      };
    }
    return PrimaryButton(
      onPressed: onPressed,
      child: Text(textButton.tr()),
    );
  }
}
