import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/blocs/forgot_password/forgot_password_cubit.dart';

import '../../app_router.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/steps_app_bar_widget.dart';

class ForgotPasswordStepsScreen extends StatefulWidget {
  const ForgotPasswordStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;
  @override
  State<ForgotPasswordStepsScreen> createState() =>
      _ForgotPasswordStepsScreenState();
}

class _ForgotPasswordStepsScreenState extends State<ForgotPasswordStepsScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return Scaffold(
      appBar: widget.child.currentIndex == 0
          ? null
          : stepsAppBarWidget(
              currentIndex: widget.child.currentIndex,
              pageCount: AppRouter.forgotPasswordSteps,
              backButton: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
                  void goBack() {
                    if (widget.child.currentIndex == 2) {
                      cubit.backFromResetPasswordStep();
                    } else if (widget.child.currentIndex == 1) {
                      cubit.backFromVerifyOtpStep();
                    }
                    widget.child.goBranch(widget.child.currentIndex - 1);
                  }

                  return CustomBackButton(
                    onTap: widget.child.currentIndex > 0 ? goBack : null,
                  );
                },
              ),
            ),
      body: widget.child,
    );
  }
}
