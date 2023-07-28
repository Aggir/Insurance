import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import '../../blocs/signup/signup_cubit.dart';
import '../../widgets/custom_back_button.dart';

class SignUpStepsScreen extends StatefulWidget {
  const SignUpStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<SignUpStepsScreen> createState() => _SignUpStepsScreenState();
}

class _SignUpStepsScreenState extends State<SignUpStepsScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Scaffold(
      appBar: widget.child.currentIndex == 0
          ? null
          : CustomAppBar.steps(
              currentIndex: widget.child.currentIndex,
              pageCount: AppRouter.signupSteps,
              backButton: BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  void goBack() {
                    if (widget.child.currentIndex == 2) {
                      if (widget.location ==
                              Routes.signupNationalIdNumberStepRoute &&
                          state.isLibyan) {
                        context.go(
                          Routes.signupVerificationStepRoute,
                        );
                        cubit.backFromNationalIdNumberPage();
                      } else if (widget.location ==
                              Routes.signupVerificationStepRoute &&
                          state.isLibyan) {
                        context.go(
                          Routes.signupSelectVerificationMethodStepRoute,
                        );
                        cubit.backFromVerificationStepPage();
                      } else {
                        widget.child.goBranch(widget.child.currentIndex - 1);
                        cubit.backFromSelectDocumentTypePage();
                      }
                    } else if (widget.location ==
                        Routes.signupPasswordStepRoute) {
                      widget.child.goBranch(widget.child.currentIndex - 1);
                      cubit.backFromPasswordPage();
                    } else {
                      widget.child.goBranch(widget.child.currentIndex - 1);
                    }
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
