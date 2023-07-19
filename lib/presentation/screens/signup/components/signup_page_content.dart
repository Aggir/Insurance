import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/screens/signup/components/signup_footer_row.dart';
import 'package:insurance_app/presentation/widgets/card_page_container.dart';
import 'package:insurance_app/presentation/widgets/custom_form_field_date_picker.dart';
import 'package:insurance_app/presentation/widgets/custom_phone_form_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/text_style_manager.dart';

class SignUpPageContent extends StatelessWidget {
  SignUpPageContent({super.key});

  void _nextButtonFunction(BuildContext context) {
    context.go(Routes.signupStepsRoute);
  }

  final TextEditingController _editingController = TextEditingController();
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
          _nextButton(context),
          CustomSpacers.medium(),
          const SignUpFooterRow(),
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
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Flexible(
                child: CustomTextFormField(
                  hintText: AppStrings.firstName.tr(),
                ),
              ),
              CustomSpacers.extraSmall(),
              Flexible(
                child: CustomTextFormField(
                  hintText: AppStrings.middleName.tr(),
                ),
              ),
              CustomSpacers.extraSmall(),
              Flexible(
                child: CustomTextFormField(
                  hintText: AppStrings.lastName.tr(),
                ),
              ),
            ],
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            hintText: AppStrings.emailAddress.tr(),
          ),
          CustomSpacers.medium(),
          CustomPhoneFormField(
            hintText: AppStrings.phoneNumberExample.tr(),
          ),
          CustomSpacers.medium(),
          CustomFormFieldDatePicker(
            controller: _editingController,
            hintText: AppStrings.birthDate.tr(),
          ),
        ],
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return PrimaryButton.fullWidth(
      onPressed: () => _nextButtonFunction(context),
      child: Text(AppStrings.next.tr().toUpperCase()),
    );
  }
}
