import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';

import 'package:insurance_app/presentation/blocs/payment/payment_cubit.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/custom_phone_form_field.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/page_content_padding.dart';
import '../../../widgets/primary_button.dart';

class PaymentSendOtpPage extends StatefulWidget {
  const PaymentSendOtpPage(this.paymentMethod, {super.key});
  final PaymentMethod? paymentMethod;
  @override
  State<PaymentSendOtpPage> createState() => _PaymentSendOtpPageState();
}

class _PaymentSendOtpPageState extends State<PaymentSendOtpPage> {
  bool formIsNotEmpty = false;

  void _checkIsFormEmpty() {
    final cubit = BlocProvider.of<PaymentCubit>(context);
    if (cubit.phoneNumberController.text.trim().isNotEmpty) {
      setState(() {
        formIsNotEmpty = true;
      });
    } else {
      setState(() {
        formIsNotEmpty = false;
      });
    }
  }

  _nextButtonFunction(context) async {
    FocusScope.of(context).unfocus();
    BlocProvider.of<PaymentCubit>(context).confirmSendOtpForm();
  }

  @override
  void initState() {
    super.initState();
    if (widget.paymentMethod != null) {
      BlocProvider.of<PaymentCubit>(context)
          .setSelectedPaymentMethod(widget.paymentMethod!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppValues.appBarHeight.r -
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
                _form(context),
                const Spacer(),
                _nextButton(context),
                CustomSpacers.medium(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.enterPhoneNumber,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return Text(
          AppStrings.youHaveChosenThisPaymentMethod.tr() +
              state.paymentMethod!.name,
          style: darkGrayBodyStyle(),
        );
      },
    );
  }

  Widget _form(BuildContext context) {
    final cubit = BlocProvider.of<PaymentCubit>(context);
    return Form(
      key: cubit.sendOtpForm,
      onChanged: _checkIsFormEmpty,
      child: CustomPhoneFormField(
        hintText: AppStrings.phoneNumberExample.tr(),
        controller: cubit.phoneNumberController,
        label: AppStrings.phoneNumber.tr(),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listenWhen: (previous, current) =>
          previous.sendOtpStatus != current.sendOtpStatus,
      listener: (context, state) {
        if (state.sendOtpStatus.isFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.sendOtpError!)));
        } else if (state.sendOtpStatus.isSuccess) {
          GoRouter.of(context).go(AppScreen.paymentVerifyOtpStep.toPath);
        }
      },
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed: state.sendOtpStatus.isLoading
              ? () {}
              : formIsNotEmpty
                  ? () => _nextButtonFunction(context)
                  : null,
          child: state.sendOtpStatus.isLoading
              ? SizedBox(
                  height: AppSizes.s20.r,
                  width: AppSizes.s20.r,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: AppSizes.s2.r,
                  ),
                )
              : Text(AppStrings.next.tr().toUpperCase()),
        );
      },
    );
  }
}
