import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/blocs/change_password/change_password_cubit.dart';
import 'package:insurance_app/presentation/screens/change_password/components/change_password_dialog.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/snackbars.dart';

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
    _unfocusFields();
    final cubit = BlocProvider.of<ChangePasswordCubit>(context);
    if (cubit.isFormValid()) {
      DialogService.loadLoadingDialog(context);
      cubit.changePassword();
    }
  }

  final FocusNode currentPasswordNode = FocusNode();
  final FocusNode newPasswordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();
  _unfocusFields() {
    currentPasswordNode.unfocus();
    newPasswordNode.unfocus();
    confirmPasswordNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocusFields,
      child: Scaffold(
          appBar: CustomAppBar.basic(
            title: AppStrings.changePassword.tr(),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  AppSizes.s68.r -
                  AppSizes.s30.r,
              child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
                listenWhen: (previous, current) =>
                    previous.changePasswordStatus !=
                    current.changePasswordStatus,
                listener: (context, state) {
                  if (state.changePasswordStatus.isFailure) {
                    DialogService.dispose();
                    SnackBars.error(context, state.changePasswordError!);
                  } else if (state.changePasswordStatus.isSuccess) {
                    DialogService.dispose();
                    DialogService.load(
                      context,
                      content: const ChangePasswordDialog(),
                    );
                  }
                },
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
            ),
          )),
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
            focusNode: currentPasswordNode,
            controller: cubit.currentPasswordController,
            hintText: AppStrings.currentPassword.tr(),
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.thisFieldIsRequired.tr();
              } else if (value.trim().length < 8) {
                return AppStrings.passwordMinLength.tr();
              } else {
                return null;
              }
            },
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            focusNode: newPasswordNode,
            controller: cubit.newPasswordController,
            hintText: AppStrings.newPassword.tr(),
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.thisFieldIsRequired.tr();
              } else if (value != cubit.confirmPasswordController.text) {
                return "";
              } else if (value.trim().length < 8) {
                return AppStrings.passwordMinLength.tr();
              } else {
                return null;
              }
            },
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            focusNode: confirmPasswordNode,
            controller: cubit.confirmPasswordController,
            hintText: AppStrings.confirmPassword.tr(),
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.thisFieldIsRequired.tr();
              } else if (value != cubit.newPasswordController.text) {
                return AppStrings.passwordAndConfirmPasswordDoNotMatch.tr();
              } else if (value.trim().length < 8) {
                return AppStrings.passwordMinLength.tr();
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
    return PrimaryButton.fullWidth(
      onPressed:
          formIsNotEmpty ? () => _changePasswordButtonFunction(context) : null,
      child: Text(
        AppStrings.changePassword.tr().toUpperCase(),
      ),
    );
  }
}
