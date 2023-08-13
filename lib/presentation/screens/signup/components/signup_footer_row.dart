import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/blocs/sign_up/sign_up_cubit.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_text_button.dart';

class SignUpFooterRow extends StatelessWidget {
  const SignUpFooterRow({super.key});
  void _loginButtonFunction(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).unfocusAllNodes();
    context.go(AppScreen.login.toPath);
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
        CustomTextButton(
          text: AppStrings.login.tr(),
          onPressed: () => _loginButtonFunction(context),
        ),
      ],
    );
  }
}
