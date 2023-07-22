import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/signup/signup_cubit.dart';
import 'package:insurance_app/presentation/widgets/cupertino_switch_tile.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/primary_button.dart';
import '../components/signup_footer_row.dart';

class SignUpPasswordStepPage extends StatefulWidget {
  const SignUpPasswordStepPage({super.key});
  // final PageController _controller;

  @override
  State<SignUpPasswordStepPage> createState() => _SignUpPasswordStepPageState();
}

class _SignUpPasswordStepPageState extends State<SignUpPasswordStepPage> {
  bool formIsNotEmpty = false;

  void _checkIsFormEmpty() {
    final cubit = BlocProvider.of<SignUpCubit>(context);
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

  void _nextButtonFunction(BuildContext context, SignUpState state) {
    if (BlocProvider.of<SignUpCubit>(context).confirmPasswordForm()) {
      FocusScope.of(context).unfocus();
      context.go(state.isLibyan
          ? Routes.signupSelectVerificationMethodStepRoute
          : Routes.signupVerificationStepRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIsFormEmpty();
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
              kToolbarHeight -
              AppSizes.s30,
          child: PageContentPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headlineTextWidget(),
                CustomSpacers.medium(),
                _bodyTextWidget(),
                CustomSpacers.large(),
                _passwordForm(context),
                CustomSpacers.medium(),
                _nationalitySwitchRow(context),
                const Spacer(),
                _nextButton(context),
                CustomSpacers.medium(),
                const SignUpFooterRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.password,
      style: headlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.passwordRecommendations,
      style: darkGrayBodyStyle(),
    ).tr();
  }

  Widget _passwordForm(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Form(
      key: cubit.passwordForm,
      onChanged: _checkIsFormEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            hintText: AppStrings.password.tr(),
            isPassword: true,
            controller: cubit.passwordController,
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
            hintText: AppStrings.confirmPassword.tr(),
            isPassword: true,
            controller: cubit.confirmPasswordController,
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

  Widget _nationalitySwitchRow(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) => CupertinoSwitchTile(
        text: AppStrings.iamLibyan.tr(),
        value: state.isLibyan,
        onTap: () => BlocProvider.of<SignUpCubit>(context).toggleIsLibyan(),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed:
              formIsNotEmpty ? () => _nextButtonFunction(context, state) : null,
          child: Text(AppStrings.next.tr().toUpperCase()),
        );
      },
    );
  }
}
