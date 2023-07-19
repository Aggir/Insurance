import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/widgets/cupertino_switch_tile.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/primary_button.dart';
import '../components/signup_footer_row.dart';

class SignUpPasswordStepPage extends StatelessWidget {
  const SignUpPasswordStepPage(this._controller, {super.key});
  final PageController _controller;
  void _nextButtonFunction(BuildContext context) {
    _controller.animateToPage((_controller.page?.round() ?? 0) + 1,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void _toggleNationalitySwitch(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height:
            MediaQuery.of(context).size.height - kToolbarHeight - AppSizes.s30,
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
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            hintText: AppStrings.password.tr(),
            isPassword: true,
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            hintText: AppStrings.confirmPassword.tr(),
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _nationalitySwitchRow(BuildContext context) {
    return CupertinoSwitchTile(
      text: AppStrings.iamLibyan.tr(),
      onTap: _toggleNationalitySwitch,
    );
  }

  Widget _nextButton(BuildContext context) {
    return PrimaryButton.fullWidth(
      onPressed: () => _nextButtonFunction(context),
      child: Text(AppStrings.next.tr().toUpperCase()),
    );
  }
}
