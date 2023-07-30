import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/screens/payment/components/payment_method_modal.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_spacers.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

class InstallmentsAmountModal extends StatefulWidget {
  const InstallmentsAmountModal({super.key});

  @override
  State<InstallmentsAmountModal> createState() => _InstallmentsAmountState();
}

class _InstallmentsAmountState extends State<InstallmentsAmountModal> {
  var value;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        top: AppValues.extraLarge,
        left: AppValues.mediumLarge,
        right: AppValues.mediumLarge,
      ).r,
      children: [
        Text(
          AppStrings.chooseTheNumberOfMonthlyInstallments.tr(),
          style: largeHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.large(),
        Text(
          AppStrings.chooseTheNumberOfMonthlyInstallmentsThatSuitYou.tr(),
          style: smallDarkGrayBodyStyle(),
        ),
        CustomSpacers.large(),
        CustomDropDownField(
          hintText: AppStrings.chooseTheNumberOfMonthlyInstallments.tr(),
          value: value,
          onChanged: (v) {
            setState(() {
              value = v;
            });
          },
          items: DUMMY.theNumberOfMonthlyInstallments
              .map(
                (type) => DropdownMenuItem(
                  value: type['value'],
                  child: Text(
                    type['value'] ?? '',
                    style: bodyStyle(),
                  ),
                ),
              )
              .toList(),
        ),
        CustomSpacers.large(),
        if (value != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.monthlyInstallment.tr(),
                style: mediumSmallHeadlineStyle(),
              ),
              Text(
                '28.125 ${AppStrings.currency.tr()}',
                style: mediumExBoldStyle(),
              ),
            ],
          ),
          CustomSpacers.large(),
          PrimaryButton.fullWidth(
            onPressed: () {
              context.pop();
              showModalBottomSheet(
                context: context,
                shape: AppValues.modalShape,
                builder: (context) =>
                    const PaymentMethodModal(isInstallments: true),
              );
            },
            child: Text(AppStrings.next.tr()),
          ),
          CustomSpacers.large(),
        ]
        // _paymentTypeRow(context )
      ],
    );
  }
}
