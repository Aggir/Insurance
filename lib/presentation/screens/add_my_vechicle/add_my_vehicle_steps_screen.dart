import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/widgets/custom_back_button.dart';
import 'package:insurance_app/presentation/widgets/steps_app_bar_widget.dart';

class AddMyVehicleStepsScreen extends StatefulWidget {
  const AddMyVehicleStepsScreen(this.child, this.location, {super.key});
  final StatefulNavigationShell child;
  final String location;

  @override
  State<AddMyVehicleStepsScreen> createState() => _AddMyVehicleStepsState();
}

class _AddMyVehicleStepsState extends State<AddMyVehicleStepsScreen> {
  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<AddMyVehicleCubit>(context);

    final BlocBuilder blockBuilder =
        BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
            builder: (context, state) {
      void onTap() {
        switch (widget.child.currentIndex) {
          case 0:
            return context.go(Routes.homeRoute);
          case 1:
            return context.go(Routes.addMyVehicleRoute);

          default:
            return context.go(Routes.homeRoute);
        }
      }

      return CustomBackButton(
        onTap: onTap,
      );
    });

    return Scaffold(
      appBar: stepsAppBarWidget(
          backButton: blockBuilder,
          currentIndex: widget.child.currentIndex,
          title: AppStrings.addVehicle.tr(),
          pageCount: AppRouter.addMyVehicleSteps),
      body: widget.child,
    );
  }
}
