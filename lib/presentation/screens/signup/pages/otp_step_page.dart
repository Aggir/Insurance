import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';
import 'package:pinput/pinput.dart';

class SignUpOtpStepPage extends StatelessWidget {
  const SignUpOtpStepPage({super.key});

  void _signUpFunction(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    if (cubit.otpForm.currentState?.validate() ?? false) {
      DialogService.loadLoadingDialog(context);
      BlocProvider.of<UserCubit>(context).signUp(
          cubit.state.userInfo!,
          cubit.state.password!,
          cubit.state.isLibyan,
          cubit.state.proofDocumentInfo!,
          cubit.otpController.text,
          nationalDocument: cubit.state.nationalDocumentInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            AppValues.appBarHeight.r -
            AppSizes.s30.r,
        child: PageContentPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CustomSpacers.large(),
              Container(
                height: AppSizes.s104.r,
                width: AppSizes.s104.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageAssets.verifyOtp,
                    ),
                  ),
                ),
              ),
              CustomSpacers.mediumLarge(),
              _headlineTextWidget(),
              CustomSpacers.medium(),
              _bodyTextWidget(context),
              CustomSpacers.large(),
              _otpForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.verifyYourPhoneNumber,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Text.rich(
          textAlign: TextAlign.center,
          style: const TextStyle(height: 1.5),
          TextSpan(
              text: AppStrings.enterVerificationNumberDescription.tr(),
              style: darkGrayBodyStyle(),
              children: [
                TextSpan(
                    text:
                        '${state.phoneCode?.replaceFirst('+', '')}${cubit.phoneNumberController.text}',
                    style: smallHeadlineStyle())
              ]),
        );
      },
    );
  }

  Widget _otpForm(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) =>
          current.authStatus != previous.authStatus,
      listener: (context, state) {
        if (state.authStatus.isFailure) {
          DialogService.dispose();
          SnackBars.error(context, state.authErrorMessage!);
        } else if (state.authStatus.isSuccess) {
          DialogService.dispose();
        }
      },
      child: Form(
        key: cubit.otpForm,
        child: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Pinput(
            length: 5,
            controller: cubit.otpController,
            onCompleted: (value) => _signUpFunction(context),
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
      ),
    );
  }
}
