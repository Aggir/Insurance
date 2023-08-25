import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/router/app_routes.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';

import '../../widgets/custom_back_button.dart';

class ForgotPasswordStepsScreen extends StatefulWidget {
  const ForgotPasswordStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;
  @override
  State<ForgotPasswordStepsScreen> createState() =>
      _ForgotPasswordStepsScreenState();
}

class _ForgotPasswordStepsScreenState extends State<ForgotPasswordStepsScreen> {
  void goBack(ForgotPasswordCubit cubit) {
    if (widget.child.currentIndex == 2) {
      cubit.backFromResetPasswordStep();
    } else if (widget.child.currentIndex == 1) {
      cubit.backFromVerifyOtpStep();
    }
    widget.child.goBranch(widget.child.currentIndex - 1);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (widget.child.currentIndex == 0) {
              context.go(AppScreen.login.toPath);
            } else {
              goBack(cubit);
            }
            return false;
          },
          child: Scaffold(
            appBar: widget.child.currentIndex == 0
                ? null
                : CustomAppBar.steps(
                    currentIndex: widget.child.currentIndex,
                    pageCount: AppRoutes.forgotPasswordBranchesCount,
                    backButton: CustomBackButton(
                      onTap: widget.child.currentIndex > 0
                          ? () => goBack(cubit)
                          : null,
                    ),
                  ),
            body: widget.child,
          ),
        );
      },
    );
  }
}
