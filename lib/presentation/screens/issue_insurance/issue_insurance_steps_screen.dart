import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/router/app_routes.dart';
import 'package:insurance_app/presentation/blocs/issue_insurance/issue_insurance_cubit.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../app/router/routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/dialog_service.dart';

class IssueInsuranceStepsScreen extends StatefulWidget {
  const IssueInsuranceStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;
  @override
  State<IssueInsuranceStepsScreen> createState() =>
      _IssueInsuranceStepsScreenState();
}

class _IssueInsuranceStepsScreenState extends State<IssueInsuranceStepsScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => DialogService.loadLoadingDialog(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.steps(
        title: AppStrings.requestInsurancePolicy.tr(),
        currentIndex: widget.child.currentIndex,
        pageCount: AppRoutes.paymentBranchesCount,
        backButton: CustomBackButton(
          onTap: widget.child.currentIndex > 0
              ? () {
                  widget.child.goBranch(widget.child.currentIndex - 1);
                }
              : () => context.go(AppScreen.carsInsurance.toPath),
        ),
      ),
      body: BlocListener<IssueInsuranceCubit, IssueInsuranceState>(
        listenWhen: (previous, current) =>
            previous.fetchInsuranceFormDataStatus !=
            current.fetchInsuranceFormDataStatus,
        listener: (context, state) {
          if (state.fetchInsuranceFormDataStatus.isFailure) {
            DialogService.dispose();
            SnackBars.error(context, state.fetchInsuranceFormDataErrorMessage!);
          } else if (state.fetchInsuranceFormDataStatus.isSuccess) {
            DialogService.dispose();
          }
        },
        child: widget.child,
      ),
    );
  }
}
