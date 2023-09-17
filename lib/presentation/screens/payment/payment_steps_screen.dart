import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/payment_method_enum.dart';
import 'package:insurance_app/app/router/app_routes.dart';
import 'package:insurance_app/domain/data_classes/my_insurances_page_parameters.dart';

import 'package:insurance_app/presentation/blocs/payment/payment_cubit.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import '../../../app/router/routes.dart';
import '../../widgets/custom_back_button.dart';

class PaymentStepsScreen extends StatefulWidget {
  const PaymentStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<PaymentStepsScreen> createState() => _PaymentStepsScreenState();
}

class _PaymentStepsScreenState extends State<PaymentStepsScreen> {
  void goBack() {
    final cubit = BlocProvider.of<PaymentCubit>(context);
    if (widget.child.currentIndex > 0) {
      if (widget.child.currentIndex == 1) {
        cubit.backFromVerifyOtpStep();
      }
      widget.child.goBranch(widget.child.currentIndex - 1);
    } else {
      context.go(AppScreen.myInsurances.toPath,
          extra: const MyInsurancesPageParameters(pageIndex: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: (state.paymentMethod?.isMoamalat ?? false)
                ? CustomAppBar.basic(
                    title: '',
                    backButton: goBack,
                  )
                : CustomAppBar.steps(
                    currentIndex: widget.child.currentIndex,
                    pageCount: AppRoutes.paymentBranchesCount,
                    backButton: CustomBackButton(onTap: goBack),
                  ),
            body: widget.child,
          );
        },
      ),
    );
  }
}
