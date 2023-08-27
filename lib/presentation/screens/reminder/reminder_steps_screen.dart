import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/router/app_routes.dart';
import 'package:insurance_app/presentation/blocs/add_reminder/add_reminder_cubit.dart';

import '../../../app/router/routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_back_button.dart';

class ReminderStepsScreen extends StatefulWidget {
  const ReminderStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<ReminderStepsScreen> createState() => _ReminderStepsScreenState();
}

class _ReminderStepsScreenState extends State<ReminderStepsScreen> {
  void goBack(AddReminderCubit cubit) {
    if (widget.child.currentIndex > 0) {
      if (widget.child.currentIndex == 1) {
        cubit.backFromUploadInsurancePicture();
      }
      widget.child.goBranch(widget.child.currentIndex - 1);
    } else {
      //todo: make it dynamic
      context.go(AppScreen.carsInsurance.toPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddReminderCubit>(context);
    return WillPopScope(
      onWillPop: () async {
        goBack(cubit);
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar.steps(
          currentIndex: widget.child.currentIndex,
          title: AppStrings.setAnAlarmForYourInsurance.tr(),
          pageCount: AppRoutes.reminderBranchesCount,
          backButton: CustomBackButton(onTap: () => goBack(cubit)),
        ),
        body: widget.child,
      ),
    );
  }
}
