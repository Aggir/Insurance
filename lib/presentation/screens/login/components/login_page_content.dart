import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/widgets/card_page_container.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_text_form_field.dart';

class LoginPageContent extends StatelessWidget {
  const LoginPageContent({super.key});

  void _forgotPasswordButtonFunction(BuildContext context) {
    context.go(Routes.forgotPasswordRoute);
  }

  void _loginButtonFunction(BuildContext context) {
    context.go(Routes.homeRoute);
  }

  void _createAccountButtonFunction(BuildContext context) {
    context.go(Routes.signupRoute);
  }

  @override
  Widget build(BuildContext context) {
    return CardPageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headlineTextWidget(),
          CustomSpacers.medium(),
          _bodyTextWidget(),
          CustomSpacers.large(),
          _loginForm(context),
          CustomSpacers.large(),
          _loginButton(context),
          CustomSpacers.medium(),
          _createAccountRow(context),
        ],
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.login,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.loginScreenDescription,
      style: darkGrayBodyStyle(),
    ).tr();
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(hintText: AppStrings.emailAddress.tr()),
          CustomSpacers.medium(),
          CustomTextFormField(
            hintText: AppStrings.password.tr(),
            isPassword: true,
          ),
          TextButton(
            onPressed: () => _forgotPasswordButtonFunction(context),
            child: Text(
              AppStrings.forgotPasswordQuestion.tr(),
              style: pressableTextStyle().copyWith(color: AppColors.gray),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        onPressed: () => _loginButtonFunction(context),
        child: Text(AppStrings.login.tr().toUpperCase()),
      ),
    );
  }

  Widget _createAccountRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.youDoNotHaveAnAccount,
          style: grayBodyStyle(),
        ).tr(),
        TextButton(
          child: Text(
            AppStrings.createAccount.tr(),
            style: pressableTextStyle(),
          ),
          onPressed: () => _createAccountButtonFunction(context),
        ),
      ],
    );
  }
}
