import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/payment/payment_cubit.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import '../../widgets/custom_back_button.dart';

class PaymentStepsScreen extends StatefulWidget {
  const PaymentStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<PaymentStepsScreen> createState() => _PaymentStepsScreenState();
}

class _PaymentStepsScreenState extends State<PaymentStepsScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentCubit>(context);
    return Scaffold(
      appBar: CustomAppBar.steps(
        currentIndex: widget.child.currentIndex,
        pageCount: AppRouter.paymentSteps,
        backButton: CustomBackButton(
          onTap: widget.child.currentIndex > 0
              ? () {
                  if (widget.child.currentIndex == 1) {
                    cubit.backFromVerifyOtpStep();
                  }
                  widget.child.goBranch(widget.child.currentIndex - 1);
                }
              //todo: make it dynamic
              : () => context.go(Routes.myInsurancesRoute, extra: 2),
        ),
      ),
      body: widget.child,
    );
  }
}
