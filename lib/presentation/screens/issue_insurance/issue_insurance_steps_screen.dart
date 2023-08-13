import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/router/app_routes.dart';

import '../../../app/router/routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_back_button.dart';

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
      body: widget.child,
    );
  }
}
