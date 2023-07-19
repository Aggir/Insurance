import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/screens/signup/components/identity_verification_image.dart';
import 'package:insurance_app/presentation/screens/signup/components/signup_footer_row.dart';
import 'package:insurance_app/presentation/screens/signup/components/upload_verification_document.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/text_style_manager.dart';

class VerificationNonLibyanPage extends StatelessWidget {
  const VerificationNonLibyanPage({super.key});
  void _createAccountButtonFunction(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IdentityVerificationImage(
          imagePath: ImageAssets.identityVerificationPassport,
        ),
        CustomSpacers.large(),
        _headlineTextWidget(),
        CustomSpacers.medium(),
        _bodyTextWidget(),
        CustomSpacers.large(),
        UploadVerificationDocument(onTap: () {}),
        CustomSpacers.medium(),
        CustomTextFormField(hintText: AppStrings.passportNumber.tr()),
        const Spacer(),
        _createAccountButton(context),
        CustomSpacers.medium(),
        const SignUpFooterRow(),
      ],
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.identityVerificationHeader,
      style: headlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.identityVerificationDescription,
      style: darkGrayBodyStyle(),
      textAlign: TextAlign.center,
    ).tr();
  }

  Widget _createAccountButton(context) {
    return PrimaryButton.fullWidth(
        onPressed: () => _createAccountButtonFunction(context),
        child: Text(
          AppStrings.createAccount.tr(),
        ));
  }
}
