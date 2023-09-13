import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/blocs/payment/payment_cubit.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';

class InstallmentsAmountModal extends StatefulWidget {
  const InstallmentsAmountModal({super.key});

  @override
  State<InstallmentsAmountModal> createState() => _InstallmentsAmountState();
}

class _InstallmentsAmountState extends State<InstallmentsAmountModal> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              top: AppValues.extraLarge,
              left: AppValues.mediumLarge,
              right: AppValues.mediumLarge,
            ).r,
            children: [
              Text(
                AppStrings.payInstallmentsViaTheBankingApplication.tr(),
                style: largeHeadlineStyle(),
                textAlign: TextAlign.center,
              ),
              CustomSpacers.extraLarge(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.installmentsCount.tr(),
                    style: mediumSmallHeadlineStyle(),
                  ),
                  Text(
                    '${state.insuranceInstallments?.installmentsCount}',
                    style: mediumExBoldStyle(),
                  ),
                ],
              ),
              CustomSpacers.large(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.monthlyInstallment.tr(),
                    style: mediumSmallHeadlineStyle(),
                  ),
                  Text(
                    '${state.insuranceInstallments?.installmentsValue} ${AppStrings.currency.tr()}',
                    style: mediumExBoldStyle(),
                  ),
                ],
              ),
              CustomSpacers.large(),
              PrimaryButton.fullWidth(
                onPressed: () {
                  context.pop();
                  DialogService.loadLoadingDialog(context);
                  BlocProvider.of<PaymentCubit>(context).pay();
                },
                child: Text(AppStrings.pay.tr()),
              ),
              CustomSpacers.large(),
            ]
            // _paymentTypeRow(context )

            );
      },
    );
  }
}
