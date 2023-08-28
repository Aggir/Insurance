import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/gender.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/validators.dart';

import 'package:insurance_app/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:insurance_app/presentation/screens/signup/components/signup_footer_row.dart';
import 'package:insurance_app/presentation/widgets/card_page_container.dart';
import 'package:insurance_app/presentation/widgets/custom_form_field_date_picker.dart';
import 'package:insurance_app/presentation/widgets/custom_phone_form_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/dialog_service.dart';

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

  void _nextButtonFunction(BuildContext context) async {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    cubit.unfocusUserInfoForm();
    if (cubit.isUserInfoFormValid()) {
      DialogService.loadLoadingDialog(context);
      await cubit.confirmUserInfoForm();
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
        BlocProvider.of<SignUpCubit>(context).unfocusUserInfoForm();
      },
      child: Align(
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
                child: BlocListener<SignUpCubit, SignUpState>(
                  listenWhen: (previous, current) =>
                      previous.checkUserInfo != current.checkUserInfo,
                  listener: (context, state) {
                    if (state.checkUserInfo.isSuccess) {
                      DialogService.dispose();
                      context.go(AppScreen.signupPasswordStep.toPath);
                    } else if (state.checkUserInfo.isFailure) {
                      DialogService.dispose();
                      SnackBars.error(
                        context,
                        state.checkUserInfoErrorMessage!,
                      );
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
                      _nextButton(context),
                      CustomSpacers.medium(),
                      const SignUpFooterRow(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.signupScreenHeader,
      style: largeHeadlineStyle(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: CustomTextFormField(
                  focusNode: cubit.firstNameFocusNode,
                  hintText: AppStrings.firstName.tr(),
                  controller: cubit.firstNameController,
                  textInputAction: TextInputAction.next,
                ),
              ),
              CustomSpacers.extraSmall(),
              Flexible(
                child: CustomTextFormField(
                  focusNode: cubit.middleNameFocusNode,
                  hintText: AppStrings.middleName.tr(),
                  controller: cubit.middleNameController,
                  textInputAction: TextInputAction.next,
                ),
              ),
              CustomSpacers.extraSmall(),
              Flexible(
                child: CustomTextFormField(
                  focusNode: cubit.lastNameFocusNode,
                  hintText: AppStrings.lastName.tr(),
                  controller: cubit.lastNameController,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            focusNode: cubit.emailFocusNode,
            hintText: AppStrings.emailAddress.tr(),
            controller: cubit.emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
            onEditingComplete: () {
              cubit.phoneNumberFocusNode.requestFocus();
            },
          ),
          CustomSpacers.medium(),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return CustomPhoneFormField(
                focusNode: cubit.phoneNumberFocusNode,
                hintText: AppStrings.phoneNumberExample.tr(),
                label: AppStrings.phoneNumber.tr(),
                controller: cubit.phoneNumberController,
                textInputAction: TextInputAction.next,
                setCode: (value) => cubit.selectPhoneCode(value!),
              );
            },
          ),
          CustomSpacers.medium(),
          CustomFormFieldDatePicker(
            hintText: AppStrings.birthDate.tr(),
            controller: cubit.birthDateController,
          ),
          CustomSpacers.medium(),
          Text(
            AppStrings.gender.tr(),
            style: smallDarkGrayBodyStyle(),
          ),
          Row(
            children: [
              _customRadioRow(value: Gender.male, title: Gender.male.name.tr()),
              CustomSpacers.medium(),
              _customRadioRow(
                  value: Gender.female, title: Gender.female.name.tr()),
            ],
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

  Widget _customRadioRow({required Gender value, required String title}) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => cubit.setGender(value),
          child: Row(
            children: [
              Radio(
                visualDensity: VisualDensity.compact,
                value: value,
                groupValue: state.gender,
                onChanged: (value) =>
                    value != null ? cubit.setGender(value) : null,
              ),
              Text(
                title,
                style: darkGrayBodyStyle(),
              )
            ],
          ),
        );
      },
    );
  }
}
