import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/widgets/custom_text_button.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/text_style_manager.dart';

class ForgotPasswordFooterRow extends StatelessWidget {
  const ForgotPasswordFooterRow({super.key});
  void _loginButtonFunction(BuildContext context) {
    context.go(AppScreen.login.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.rememberedYourAccountQuestion,
          style: grayBodyStyle(),
        ).tr(),
        CustomTextButton(
          text: AppStrings.login.tr(),
          onPressed: () => _loginButtonFunction(context),
        ),
      ],
    );
  }
}
