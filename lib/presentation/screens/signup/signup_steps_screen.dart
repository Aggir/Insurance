import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/router/app_routes.dart';
import 'package:insurance_app/app/router/routes.dart';

import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import '../../blocs/sign_up/sign_up_cubit.dart';
import '../../widgets/custom_back_button.dart';

class SignUpStepsScreen extends StatefulWidget {
  const SignUpStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<SignUpStepsScreen> createState() => _SignUpStepsScreenState();
}

class _SignUpStepsScreenState extends State<SignUpStepsScreen> {
  void goBack(SignUpState state, SignUpCubit cubit) {
    if (widget.child.currentIndex == 2) {
      if (widget.location == AppScreen.signupNationalInfoStep.toPath &&
          state.isLibyan) {
        context.go(
          AppScreen.signupProofInfoStep.toPath,
        );
        cubit.backFromNationalIdNumberPage();
      } else if (widget.location == AppScreen.signupProofInfoStep.toPath &&
          state.isLibyan) {
        context.go(
          AppScreen.signupSelectProofTypeStep.toPath,
        );
        cubit.backFromVerificationStepPage();
      } else {
        widget.child.goBranch(widget.child.currentIndex - 1);
        cubit.backFromSelectDocumentTypePage();
      }
    } else if (widget.location == AppScreen.signupPasswordStep.toPath) {
      widget.child.goBranch(widget.child.currentIndex - 1);
      cubit.backFromPasswordPage();
    } else {
      widget.child.goBranch(widget.child.currentIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);

    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (widget.child.currentIndex == 0) {
              context.go(AppScreen.login.toPath);
            } else {
              goBack(state, cubit);
            }

            return false;
          },
          child: Scaffold(
            appBar: widget.child.currentIndex == 0
                ? null
                : CustomAppBar.steps(
                    currentIndex: widget.child.currentIndex,
                    pageCount: AppRoutes.signupBranchesCount,
                    backButton: CustomBackButton(
                      onTap: widget.child.currentIndex > 0
                          ? () => goBack(state, cubit)
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
