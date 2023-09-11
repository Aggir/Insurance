import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/domain/data_classes/payment_step_parameters.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';

import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

import '../../../../app/router/routes.dart';

class PaymentMethodModal extends StatelessWidget {
  const PaymentMethodModal(this.insurance, {super.key});
  final InsuranceEntity insurance;

  void _selectPaymentMethodFunction(BuildContext context, method) {
    context.go(AppScreen.payment.toPath,
        extra:
            PaymentStepParameters(paymentMethod: method, insurance: insurance));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        top: AppValues.extraLarge,
        left: AppValues.mediumLarge,
        right: AppValues.mediumLarge,
      ).r,
      children: [
        Text(
          AppStrings.chooseTheAppropriatePaymentMethod.tr(),
          style: largeHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.large(),
        Text(
          AppStrings.chooseThePaymentMethodThatSuitsYou.tr(),
          style: smallDarkGrayBodyStyle(),
        ),
        CustomSpacers.large(),
        ...DUMMY.paymentMethods
            .map((method) => paymentMethodRow(
                  context,
                  method,
                ))
            .toList(),
      ],
    );
  }

  Widget paymentMethodRow(BuildContext context, PaymentMethod method) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(AppValues.small).r,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grayLight),
                borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: AppSizes.s48.r,
                    height: AppSizes.s48.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grayLight),
                      borderRadius:
                          BorderRadius.circular(AppValues.mediumRadius.r),
                      color: AppColors.lightest,
                    ),
                    child: Image.asset(
                      method.imagePath,
                      width: AppSizes.s46.r,
                    ),
                  ),
                  CustomSpacers.small(),
                  Text.rich(
                    TextSpan(
                      text: AppStrings.paymentBy.tr(),
                      style: darkGrayBodyStyle(),
                      children: [
                        TextSpan(text: method.name, style: smallHeadlineStyle())
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _selectPaymentMethodFunction(context, method),
                ),
              ),
            ),
          ],
        ),
        CustomSpacers.medium()
      ],
    );
  }
}
