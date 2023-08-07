import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';
import 'package:insurance_app/presentation/widgets/secondary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../app_router.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/page_content_padding.dart';
import '../../../widgets/primary_button.dart';
import '../../payment/components/payment_type_modal.dart';

class InstallmentDetailsStepPage extends StatefulWidget {
  const InstallmentDetailsStepPage({super.key});

  @override
  State<InstallmentDetailsStepPage> createState() =>
      _InstallmentDetailsStepPageState();
}

class _InstallmentDetailsStepPageState
    extends State<InstallmentDetailsStepPage> {
  void _completeTheInsurancePolicyPayment(context) {
    showModalBottomSheet(
      context: context,
      shape: AppValues.modalShape,
      builder: (context) => const PaymentTypeModal(),
    );
  }

  void _issueTheInsurancePolicyAndPayLate(BuildContext context) {
    context.push(Routes.loadingRoute);
    Future.delayed(const Duration(seconds: 2), () {
      context.pop();
      context.go(Routes.myVehiclesRoute, extra: true);
    });
  }

  bool get _radiosSelected =>
      selectedRadio.contains('1') && selectedRadio.contains('2');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            AppValues.appBarHeight.r -
            AppSizes.s30.r,
        child: PageContentPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppStrings.installmentDetails.tr(),
                  style: largeHeadlineStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomSpacers.mediumLarge(),
              _installmentDetailsWidget(context),
              CustomSpacers.mediumLarge(),
              Text(
                AppStrings.pleaseAcceptToContinue.tr(),
                style: extraSmallHeadlineStyle(),
              ),
              RadioListTile.adaptive(
                title: Text(
                  AppStrings.iAcceptTheGeneralTermsOfTheInsurancePolicy.tr(),
                  style: bodyStyle(),
                ),
                contentPadding: const EdgeInsets.all(0),
                value: '1',
                toggleable: true,
                groupValue: selectedRadio.contains('1') ? '1' : null,
                onChanged: (v) => setState(() {
                  if (selectedRadio.contains('1')) {
                    selectedRadio.remove('1');
                  } else {
                    selectedRadio.add('1');
                  }
                }),
              ),
              RadioListTile(
                title: Text(
                  AppStrings.iAgreeToPayTheFeeAsShownInTheTotal.tr(),
                  style: bodyStyle(),
                ),
                contentPadding: const EdgeInsets.all(0),
                toggleable: true,
                value: '2',
                groupValue: selectedRadio.contains('2') ? '2' : null,
                onChanged: (v) => setState(() {
                  if (selectedRadio.contains('2')) {
                    selectedRadio.remove('2');
                  } else {
                    selectedRadio.add('2');
                  }
                }),
              ),
              const Spacer(),
              PrimaryButton.fullWidth(
                onPressed: _radiosSelected
                    ? () => _completeTheInsurancePolicyPayment(context)
                    : null,
                child: Text(AppStrings.completeTheInsurancePolicyPayment.tr()),
              ),
              CustomSpacers.medium(),
              SecondaryButton.fullWidth(
                onPressed: _radiosSelected
                    ? () => _issueTheInsurancePolicyAndPayLate(context)
                    : null,
                child: Text(AppStrings.issueTheInsurancePolicyAndPayLater.tr()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _installmentDetailsWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            SvgAssets.installmentCard, fit: BoxFit.fill,
            // width: double.infinity,f
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.medium, vertical: AppValues.mediumLarge)
              .r,
          child: Column(
            children: [
              _detailRow(AppStrings.netInstallment.tr(), '25.000'),
              CustomSpacers.medium(),
              _detailRow(AppStrings.tax.tr(), '0.500'),
              CustomSpacers.medium(),
              _detailRow(AppStrings.stampDuty.tr(), '0.500'),
              CustomSpacers.medium(),
              _detailRow(AppStrings.supervision.tr(), '0.125'),
              CustomSpacers.medium(),
              _detailRow(AppStrings.issuanceFee.tr(), '2.125'),
              CustomSpacers.mediumLarge(),
              Container(
                color: AppColors.primaryLight,
                width: double.infinity,
                height: 1.r,
              ),
              CustomSpacers.mediumLarge(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.total.tr(),
                    style: mediumSmallHeadlineStyle(),
                  ),
                  Text(
                    '28.125 ${AppStrings.currency.tr()}',
                    style: getExtraBoldStyle(
                        fontSize: FontSize.s16, color: AppColors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: darkGrayBodyStyle(),
        ),
        Text(
          value.toString(),
          style: smallHeadlineStyle(),
        ),
      ],
    );
  }

  Set<String> selectedRadio = {};
}
