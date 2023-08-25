import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/screens/home/components/vehicle_list_item.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import '../../blocs/my_vehicles/my_vehicles_cubit.dart';

class MyHiddenVehiclesScreen extends StatefulWidget {
  const MyHiddenVehiclesScreen({super.key});

  @override
  State<MyHiddenVehiclesScreen> createState() => _MyHiddenVehiclesScreenState();
}

class _MyHiddenVehiclesScreenState extends State<MyHiddenVehiclesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.basic(
          title: AppStrings.myHiddenVehicles.tr(),
          backButton: () {
            context.pop();
          },
        ),
        body: _getContent(context),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<MyVehiclesCubit>(context).fetchHiddenVehicles();
    super.initState();
  }

  Widget _getContent(BuildContext context) {
    final cubit = BlocProvider.of<MyVehiclesCubit>(context);
    return BlocBuilder<MyVehiclesCubit, MyVehiclesState>(
      builder: (context, state) {
        if (state.fetchMyHiddenVehiclesStatus.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else if (state.fetchMyHiddenVehiclesStatus.isSuccess &&
            state.myHiddenVehicles!.isNotEmpty) {
          return Stack(
            children: [
              ListView.separated(
                controller: cubit.hiddenVehiclesScrollController,
                padding: const EdgeInsets.all(AppValues.medium).r,
                separatorBuilder: (context, index) => CustomSpacers.medium(),
                shrinkWrap: true,
                itemCount: state.myHiddenVehicles?.length ?? 0,
                itemBuilder: (context, index) => VehicleListItem(
                  state.myHiddenVehicles![index],
                ),
              ),
              if (state.fetchMoreHiddenVehiclesStatus.isLoading)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    backgroundColor: AppColors.lightest,
                    radius: AppSizes.s20.r,
                    child: Padding(
                      padding: const EdgeInsets.all(AppValues.small).r,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: AppSizes.s4.r,
                      ),
                    ),
                  ),
                ),
            ],
          );
        } else {
          return _emptyListState(context);
        }
      },
    );
  }

  Widget _emptyListState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.large).r,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImageAssets.emptyList,
              height: AppSizes.s200.r,
              width: AppSizes.s200.r,
            ),
            CustomSpacers.large(),
            Text(
              AppStrings.youDoNotHaveAnyHiddenVehicles.tr(),
              textAlign: TextAlign.center,
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              AppStrings.youCanHideVehicleBy.tr(),
              textAlign: TextAlign.center,
              style: grayBodyStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
