import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/blocs/payment/payment_cubit.dart';
import 'package:insurance_app/presentation/screens/insurance_payment/components/payment_completed_dialog.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:pinput/pinput.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

import '../../../../app/functions.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_text_button.dart';
import '../../../widgets/page_content_padding.dart';

class PaymentVerifyOtpPage extends StatefulWidget {
  const PaymentVerifyOtpPage({super.key});

  @override
  State<PaymentVerifyOtpPage> createState() => _PaymentVerifyOtpPageState();
}

class _PaymentVerifyOtpPageState extends State<PaymentVerifyOtpPage> {
  _otpOnComplete(PaymentCubit cubit) {
    cubit.confirmVerifyOtpForm();
  }

  bool isResendButtonActive = false;
  _resendOtp() {
    BlocProvider.of<PaymentCubit>(context).startTimer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            kToolbarHeight -
            AppSizes.s30.r,
        child: PageContentPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CustomSpacers.large(),
              BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  return Container(
                    height: AppSizes.s104.r,
                    width: AppSizes.s104.r,
                    padding: const EdgeInsets.all(AppValues.medium).r,
                    decoration: BoxDecoration(
                      color: AppColors.lightest,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.grayLight),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      state.paymentMethod!.imagePath,
                    ),
                  );
                },
              ),
              CustomSpacers.medium(),
              CustomSpacers.small(),
              _headlineTextWidget(),
              CustomSpacers.medium(),
              _bodyTextWidget(),
              CustomSpacers.large(),
              _otpForm(context),
              CustomSpacers.large(),
              _resendFooterRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.enterVerificationNumber,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return Text.rich(
          textAlign: TextAlign.center,
          style: const TextStyle(height: 1.5),
          TextSpan(
              text: AppStrings.enterVerificationNumberDescription.tr(),
              style: darkGrayBodyStyle(),
              children: [
                TextSpan(
                    text: state.phoneNumber ?? '', style: smallHeadlineStyle())
              ]),
        );
      },
    );
  }

  Widget _otpForm(BuildContext context) {
    final cubit = BlocProvider.of<PaymentCubit>(context);
    return BlocListener<PaymentCubit, PaymentState>(
        listenWhen: (previous, current) =>
            current.verifyOtpStatus != previous.verifyOtpStatus,
        listener: (context, state) {
          if (state.verifyOtpStatus.isLoading) {
            DialogService.loadLoadingDialog(context);
          } else if (state.verifyOtpStatus.isSuccess) {
            DialogService.dispose();
            DialogService.load(context,
                content: const PaymentCompletedDialog());
          } else if (state.verifyOtpStatus.isFailure) {
            DialogService.dispose();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.verifyOtpError!)));
          }
        },
        child: Form(
          key: cubit.verifyOtpForm,
          child: Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Pinput(
              length: 4,
              controller: cubit.otpController,
              onCompleted: (value) => _otpOnComplete(cubit),
              defaultPinTheme: PinTheme(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.grayLight),
                  borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
                ),
                height: AppSizes.s72.r,
                width: AppSizes.s72.r,
              ),
              focusedPinTheme: PinTheme(
                decoration: BoxDecoration(
                  color: AppColors.lightest,
                  border: Border.all(color: AppColors.grayLight),
                  borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
                ),
                height: AppSizes.s72.r,
                width: AppSizes.s72.r,
              ),
            ),
          ),
        ));
  }

  _resendFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.left.tr(),
          style: grayBodyStyle(),
        ),
        BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            return Text(
              '${formatDuration(Duration(seconds: state.resendCounterInSeconds))} ',
              style: smallDarkGrayHeadlineStyle()
                  .copyWith(color: AppColors.secondary),
            );
          },
        ),
        Text(
          AppStrings.minute.tr(),
          style: grayBodyStyle(),
        ),
        CustomSpacers.small(),
        BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            return CustomTextButton(
              onPressed: state.isResendButtonActive ? _resendOtp : null,
              text: AppStrings.resend.tr(),
            );
          },
        )
      ],
    );
  }
}
