import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import '../../blocs/signup/signup_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import 'components/custom_indicator.dart';

class SignUpStepsPage extends StatefulWidget {
  const SignUpStepsPage(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<SignUpStepsPage> createState() => _SignUpStepsPageState();
}

class _SignUpStepsPageState extends State<SignUpStepsPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Scaffold(
      appBar: widget.child.currentIndex == 0
          ? null
          : AppBar(
              backgroundColor: AppColors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
              leading: BlocBuilder<SignUpCubit, SignUpState>(
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
              actions: [
                CustomIndicator(
                  currentPage: widget.child.currentIndex.toDouble(),
                  pageCount: AppRouter.signupSteps,
                ),
              ],
            ),
      body: widget.child,
    );
  }
}
