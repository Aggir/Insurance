import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/blocs/change_password/change_password_cubit.dart';
import 'package:insurance_app/presentation/screens/change_password/components/change_password_dialog.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';
import '../../widgets/custom_spacers.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/page_content_padding.dart';
import '../../widgets/primary_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool formIsNotEmpty = false;

  void _checkIsFormEmpty() {
    final cubit = BlocProvider.of<ChangePasswordCubit>(context);
    if (cubit.currentPasswordController.text.trim().isNotEmpty &&
        cubit.newPasswordController.text.trim().isNotEmpty &&
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

  void _changePasswordButtonFunction(BuildContext context) {
    BlocProvider.of<ChangePasswordCubit>(context).confirmForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.build(
          title: AppStrings.changePassword.tr(),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppSizes.s68.r -
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
                        image: AssetImage(ImageAssets.newPassword),
                      ),
                    ),
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
        ));
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
      style: darkGrayBodyStyle(),
    );
  }

  Widget _resetPasswordForm(BuildContext context) {
    final cubit = BlocProvider.of<ChangePasswordCubit>(context);
    return Form(
      key: cubit.formKey,
      onChanged: _checkIsFormEmpty,
      child: Column(
        children: [
          CustomTextFormField(
            controller: cubit.currentPasswordController,
            hintText: AppStrings.currentPassword.tr(),
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.thisFieldIsRequired.tr();
              } else {
                return null;
              }
            },
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            controller: cubit.newPasswordController,
            hintText: AppStrings.newPassword.tr(),
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
              } else if (value != cubit.newPasswordController.text) {
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
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          previous.changePasswordStatus != current.changePasswordStatus,
      listener: (context, state) {
        if (state.changePasswordStatus.isSuccess) {
          context.pop();
          DialogService.load(context, content: const ChangePasswordDialog());
        } else if (state.changePasswordStatus.isFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.changePasswordError!),
            ),
          );
        }
      },
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed: state.changePasswordStatus.isLoading
              ? () {}
              : formIsNotEmpty
                  ? () => _changePasswordButtonFunction(context)
                  : null,
          child: state.changePasswordStatus.isLoading
              ? SizedBox(
                  height: AppSizes.s20.r,
                  width: AppSizes.s20.r,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: AppSizes.s2.r,
                  ),
                )
              : Text(
                  AppStrings.changePassword.tr().toUpperCase(),
                ),
        );
      },
    );
  }
}
