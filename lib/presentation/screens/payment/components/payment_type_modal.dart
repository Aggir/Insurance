import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/blocs/payment/payment_cubit.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/screens/payment/components/installments_amount_modal.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';

class PaymentTypeModal extends StatelessWidget {
  const PaymentTypeModal({super.key});

  void _instantPaymentFunction(BuildContext context) {
    context.pop();
    //TODO : DELETE THIS!!
    DialogService.loadLoadingDialog(context);
    BlocProvider.of<PaymentCubit>(context).pay();
  }

  void _payInInstallmentsFunction(BuildContext context) {
    final paymentCubit = BlocProvider.of<PaymentCubit>(context);
    paymentCubit.getInsuranceInstallments(
        insurance: paymentCubit.state.insurance!,
        userId: BlocProvider.of<UserCubit>(context).state.user!.userId);

    DialogService.loadLoadingDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listenWhen: (previous, current) =>
          previous.getInsuranceInstallmentsStatus !=
          current.getInsuranceInstallmentsStatus,
      listener: (context, state) {
        if (state.getInsuranceInstallmentsStatus.isFailure) {
          DialogService.dispose();
          SnackBars.error(context, state.getInsuranceInstallmentsErrorMessage!);
        } else if (state.getInsuranceInstallmentsStatus.isSuccess) {
          DialogService.dispose();
          context.pop();
          showModalBottomSheet(
            context: context,
            shape: AppValues.modalShape,
            builder: (context) => BlocProvider.value(
              value: BlocProvider.of<PaymentCubit>(context),
              child: const InstallmentsAmountModal(),
            ),
          );
        }
      },
      child: ListView(
        shrinkWrap: true,
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
          _paymentTypeRow(
            context,
            AppStrings.instantPayment.tr(),
            SvgAssets.checkCircle,
            () => _instantPaymentFunction(context),
          ),
          _paymentTypeRow(
            context,
            AppStrings.payInInstallments.tr(),
            SvgAssets.installmentIcon,
            () => _payInInstallmentsFunction(context),
          ),
          CustomSpacers.large(),
          // _paymentTypeRow(context )
        ],
      ),
    );
  }

  Widget _paymentTypeRow(BuildContext context, String title, String svgPath,
      void Function() onTap) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(AppValues.medium).r,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grayLight),
                borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    svgPath,
                    height: AppSizes.s28.r,
                    width: AppSizes.s28.r,
                  ),
                  CustomSpacers.small(),
                  Text(
                    title,
                    style: darkGrayBodyStyle(),
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
                  onTap: onTap,
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
