import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/blocs/login/login_cubit.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/widgets/card_page_container.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackbars.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_text_button.dart';
import '../../../widgets/custom_text_form_field.dart';

class LoginPageContent extends StatelessWidget {
  const LoginPageContent({super.key});

  void _forgotPasswordButtonFunction(BuildContext context) {
    BlocProvider.of<LoginCubit>(context).unfocus();
    context.go(AppScreen.forgotPassword.toPath);
  }

  void _loginButtonFunction(BuildContext context) async {
    final cubit = BlocProvider.of<LoginCubit>(context);
    cubit.unfocus();
    if (cubit.isFormValid) {
      DialogService.loadLoadingDialog(context);
      await BlocProvider.of<UserCubit>(context).login(
        cubit.emailAndPhoneController.text.trim(),
        cubit.passwordController.text.trim(),
      );
    }
  }

  void _createAccountButtonFunction(BuildContext context) {
    BlocProvider.of<LoginCubit>(context).unfocus();
    context.go(AppScreen.signup.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return CardPageContainer(
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.authStatus.isFailure) {
            DialogService.dispose();
            SnackBars.error(context, state.authErrorMessage!);
          } else if (state.authStatus.isSuccess) {
            DialogService.dispose();
          }
        },
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
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            focusNode: cubit.emailAndPhoneFocusNode,
            controller: cubit.emailAndPhoneController
              ..text = "h.sherif@wassel.ly",
            hintText: AppStrings.phoneNumberOrEmailAddress.tr(),
            textInputAction: TextInputAction.next,
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            focusNode: cubit.passwordFocusNode,
            controller: cubit.passwordController..text = "password",
            hintText: AppStrings.password.tr(),
            textInputAction: TextInputAction.done,
            isPassword: true,
          ),
          CustomTextButton(
            onPressed: () => _forgotPasswordButtonFunction(context),
            text: AppStrings.forgotPasswordQuestion.tr(),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return PrimaryButton.fullWidth(
      onPressed: () => _loginButtonFunction(context),
      child: Text(AppStrings.login.tr().toUpperCase()),
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
        CustomTextButton(
          text: AppStrings.createAccount.tr(),
          onPressed: () => _createAccountButtonFunction(context),
        ),
      ],
    );
  }
}
