import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/signup/signup_cubit.dart';
import 'package:insurance_app/presentation/screens/signup/components/signup_footer_row.dart';
import 'package:insurance_app/presentation/widgets/card_page_container.dart';
import 'package:insurance_app/presentation/widgets/custom_form_field_date_picker.dart';
import 'package:insurance_app/presentation/widgets/custom_phone_form_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style_manager.dart';

class SignUpUserInfoStepPage extends StatefulWidget {
  const SignUpUserInfoStepPage({super.key});

  @override
  State<SignUpUserInfoStepPage> createState() => _SignUpUserInfoStepPageState();
}

class _SignUpUserInfoStepPageState extends State<SignUpUserInfoStepPage> {
  bool formIsNotEmpty = false;

  void _checkIsFormEmpty() {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    if (cubit.firstNameController.text.trim().isNotEmpty &&
        cubit.middleNameController.text.trim().isNotEmpty &&
        cubit.lastNameController.text.trim().isNotEmpty &&
        cubit.emailController.text.trim().isNotEmpty &&
        cubit.phoneNumberController.text.trim().isNotEmpty &&
        cubit.birthDateController.text.trim().isNotEmpty) {
      setState(() {
        formIsNotEmpty = true;
      });
    } else {
      setState(() {
        formIsNotEmpty = false;
      });
    }
  }

  void _nextButtonFunction(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (BlocProvider.of<SignUpCubit>(context).confirmUserInfoForm()) {
      context.go(Routes.signupPasswordStepRoute);
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
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryLightest,
                image: const DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(ImageAssets.signupBackground),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightest,
                      image: const DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(ImageAssets.signupBackground),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CardPageContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headlineTextWidget(),
                        CustomSpacers.medium(),
                        _bodyTextWidget(),
                        CustomSpacers.large(),
                        _loginForm(context),
                        CustomSpacers.large(),
                        _nextButton(context),
                        CustomSpacers.medium(),
                        const SignUpFooterRow(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.signupScreenHeader,
      style: headlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.signupScreenDescription,
      style: darkGrayBodyStyle(),
    ).tr();
  }

  Widget _loginForm(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Form(
      key: cubit.userInfoForm,
      onChanged: _checkIsFormEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Flexible(
                child: CustomTextFormField(
                  hintText: AppStrings.firstName.tr(),
                  controller: cubit.firstNameController,
                ),
              ),
              CustomSpacers.extraSmall(),
              Flexible(
                child: CustomTextFormField(
                  hintText: AppStrings.middleName.tr(),
                  controller: cubit.middleNameController,
                ),
              ),
              CustomSpacers.extraSmall(),
              Flexible(
                child: CustomTextFormField(
                  hintText: AppStrings.lastName.tr(),
                  controller: cubit.lastNameController,
                ),
              ),
            ],
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            hintText: AppStrings.emailAddress.tr(),
            controller: cubit.emailController,
          ),
          CustomSpacers.medium(),
          CustomPhoneFormField(
            hintText: AppStrings.phoneNumberExample.tr(),
            label: AppStrings.phoneNumber.tr(),
            controller: cubit.phoneNumberController,
          ),
          CustomSpacers.medium(),
          CustomFormFieldDatePicker(
            hintText: AppStrings.birthDate.tr(),
            controller: cubit.birthDateController,
          ),
        ],
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return PrimaryButton.fullWidth(
      onPressed: formIsNotEmpty ? () => _nextButtonFunction(context) : null,
      child: Text(AppStrings.next.tr().toUpperCase()),
    );
  }
}
