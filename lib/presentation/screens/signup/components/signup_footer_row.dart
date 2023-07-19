import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_strings.dart';
import '../../../app_router.dart';
import '../../../theme/text_style_manager.dart';

class SignUpFooterRow extends StatelessWidget {
  const SignUpFooterRow({super.key});
  void _loginButtonFunction(BuildContext context) {
    context.go(Routes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.doYouHaveAnAccount,
          style: grayBodyStyle(),
        ).tr(),
        TextButton(
          child: Text(
            AppStrings.login.tr(),
            style: pressableTextStyle(),
          ),
          onPressed: () => _loginButtonFunction(context),
        ),
      ],
    );
  }
}
