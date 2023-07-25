import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

class MyPaymentsScreen extends StatelessWidget {
  const MyPaymentsScreen({super.key});

  void _insuranceServicesFunction(BuildContext context) {
    context.go(Routes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        title: AppStrings.myPayments.tr(),
        backButton: () {
          context.go(Routes.moreRoute);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppValues.large,
                horizontal: AppValues.mediumLarge,
              ).r,
              child: CustomTextFormField(
                hintText: AppStrings.search.tr(),
                prefixIcon: SvgPicture.asset(
                  SvgAssets.search,
                  height: AppSizes.s24.r,
                  width: AppSizes.s24.r,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            CustomSpacers.large(),
            _getContent(context)
          ],
        ),
      ),
    );
  }

  final String _insuranceType = 'سداد وثيقة تأمين سيارة اجباري';
  final String _date = 'السبت 9:30 م';
  final PaymentStatus _status = PaymentStatus.success;
  Widget _getContent(BuildContext context) {
    final random = Random();
    if (random.nextBool()) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.extraLarge).r,
        child: Column(
          children: [
            Image.asset(
              ImageAssets.emptyList,
              width: AppSizes.s200.r,
              height: AppSizes.s200.r,
            ),
            CustomSpacers.large(),
            Text(
              AppStrings.youDoNotHaveAnyPayments.tr(),
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              AppStrings.youDidNotPayAnyInsuranceYet.tr(),
              style: grayBodyStyle(),
            ),
            CustomSpacers.large(),
            PrimaryButton.fullWidth(
              child: Text(
                AppStrings.insuranceServices.tr(),
              ),
              onPressed: () => _insuranceServicesFunction(context),
            )
          ],
        ),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding:
            const EdgeInsets.symmetric(horizontal: AppValues.mediumLarge).r,
        children: [
          myPaymentItem(
            imgPath: ImageAssets.mobicash,
            cost: 90,
            paymentMethod: 'موبي كاش',
            insuranceType: _insuranceType,
            date: _date,
            status: _status,
          ),
          CustomSpacers.medium(),
          const CustomDivider(),
          CustomSpacers.medium(),
          myPaymentItem(
            imgPath: ImageAssets.moamalat,
            cost: 30,
            paymentMethod: 'معاملات',
            insuranceType: _insuranceType,
            date: _date,
            status: _status,
          ),
        ],
      );
    }
  }

  Widget myPaymentItem({
    required String imgPath,
    required String insuranceType,
    required String paymentMethod,
    required PaymentStatus status,
    required String date,
    required int cost,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppSizes.s48.r,
          width: AppSizes.s48.r,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grayLight),
              borderRadius: BorderRadius.circular(100)),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(imgPath),
        ),
        CustomSpacers.medium(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              insuranceType,
              style: smallHeadlineStyle(),
            ),
            CustomSpacers.small(),
            Text(
              paymentMethod,
              style: smallDarkGrayBodyStyle(),
            ),
            CustomSpacers.small(),
            Text(
              date,
              style: extraSmallGrayBodyStyle(),
            ),
          ],
        ),
        CustomSpacers.medium(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: '$cost  ',
                style: getExtraBoldStyle(
                    color: AppColors.black, fontSize: FontSize.s16),
                children: [
                  TextSpan(
                    text: AppStrings.dinar.tr(),
                    style: smallDarkGrayBodyStyle(),
                  ),
                ],
              ),
            ),
            CustomSpacers.small(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: AppSizes.s5.r,
                  backgroundColor: status.isSuccess
                      ? AppColors.secondary
                      : status.isFailed
                          ? AppColors.danger
                          : AppColors.primaryLight,
                ),
                CustomSpacers.small(),
                Text(
                  status.string.tr(),
                  style: extraSmallHeadlineStyle(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
