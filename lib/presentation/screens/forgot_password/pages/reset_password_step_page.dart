import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../blocs/forgot_password/forgot_password_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/page_content_padding.dart';

class ForgotPasswordRestPasswordPage extends StatefulWidget {
  const ForgotPasswordRestPasswordPage({super.key});

  @override
  State<ForgotPasswordRestPasswordPage> createState() =>
      _ForgotPasswordRestPasswordPageState();
}

class _ForgotPasswordRestPasswordPageState
    extends State<ForgotPasswordRestPasswordPage> {
  bool formIsNotEmpty = false;

  void _checkIsFormEmpty() {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    if (cubit.passwordController.text.trim().isNotEmpty &&
        cubit.confirmPasswordController.text.trim().isNotEmpty) {
      setState(() {
        formIsNotEmpty = true;
      });
    } else {
      setState(() {
        formIsNotEmpty = false;
      });
    }
  }

  _nextButtonFunction(BuildContext context) {
    FocusScope.of(context).unfocus();
    BlocProvider.of<ForgotPasswordCubit>(context).confirmResetPasswordForm();
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
              CustomSpacers.large(),
              Container(
                height: AppSizes.s104.r,
                width: AppSizes.s104.r,
                decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                        image: AssetImage(ImageAssets.newPassword))),
              ),
              CustomSpacers.medium(),
              CustomSpacers.small(),
              _headlineTextWidget(),
              CustomSpacers.medium(),
              _bodyTextWidget(),
              CustomSpacers.large(),
              _resetPasswordForm(context),
              const Spacer(),
              _changePasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.newPassword,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.passwordRecommendations.tr(),
      textAlign: TextAlign.center,
      style: darkGrayBodyStyle().copyWith(height: 1.5),
    );
  }

  Widget _resetPasswordForm(BuildContext context) {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return Form(
      key: cubit.resetPasswordForm,
      onChanged: _checkIsFormEmpty,
      child: Column(
        children: [
          CustomTextFormField(
            controller: cubit.passwordController,
            hintText: AppStrings.password.tr(),
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.thisFieldIsRequired.tr();
              } else if (value != cubit.confirmPasswordController.text) {
                return "";
              } else {
                return null;
              }
            },
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            controller: cubit.confirmPasswordController,
            hintText: AppStrings.confirmPassword.tr(),
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.thisFieldIsRequired.tr();
              } else if (value != cubit.passwordController.text) {
                return AppStrings.passwordAndConfirmPasswordDoNotMatch.tr();
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _changePasswordButton() {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          previous.resetPasswordStatus != current.resetPasswordStatus,
      listener: (context, state) {
        if (state.resetPasswordStatus.isSuccess) {
          context.go(Routes.homeRoute);
        }
      },
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed: state.sendOtpStatus.isLoading
              ? () {}
              : formIsNotEmpty
                  ? () => _nextButtonFunction(context)
                  : null,
          child: state.resetPasswordStatus.isLoading
              ? SizedBox(
                  height: AppSizes.s20.r,
                  width: AppSizes.s20.r,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: AppSizes.s2.r,
                  ),
                )
              : Text(AppStrings.changePassword.tr().toUpperCase()),
        );
      },
    );
  }
}
