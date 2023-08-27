import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/router/app_routes.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_back_button.dart';

class AddMyVehicleStepsScreen extends StatefulWidget {
  const AddMyVehicleStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<AddMyVehicleStepsScreen> createState() => _AddMyVehicleStepsState();
}

class _AddMyVehicleStepsState extends State<AddMyVehicleStepsScreen> {
  void goBack() {
    switch (widget.child.currentIndex) {
      case 0:
        return context.go(AppScreen.home.toPath);
      case 1:
        if (widget.location == AppScreen.addMyVehicleDetailsStepTwo.toPath) {
          return context.go(AppScreen.addMyVehicleDetailsStepOne.toPath);
        }
        return widget.child.goBranch(widget.child.currentIndex - 1);
      default:
        return widget.child.goBranch(widget.child.currentIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar.steps(
            backButton: CustomBackButton(
              onTap: goBack,
            ),
            currentIndex: widget.child.currentIndex,
            title: AppStrings.addVehicle.tr(),
            pageCount: AppRoutes.addMyVehicleBranchesCount),
        body: widget.child,
      ),
    );
  }
}
