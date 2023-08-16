import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/screens/home/components/vehicle_list_item.dart';
import 'package:insurance_app/presentation/screens/issue_insurance/components/issue_completed_dialog.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/router/routes.dart';
import '../../../blocs/my_vehicles/my_vehicles_cubit.dart';

class MyVehiclesPage extends StatefulWidget {
  const MyVehiclesPage(this.showIssueDialog, {super.key});
  final bool showIssueDialog;

  @override
  State<MyVehiclesPage> createState() => _MyVehiclesPageState();
}

class _MyVehiclesPageState extends State<MyVehiclesPage> {
  _addVehicleFunction(BuildContext context) {
    context.go(AppScreen.addMyVehicle.toPath);
  }

  @override
  void initState() {
    super.initState();
    if (widget.showIssueDialog) {
      SchedulerBinding.instance.addPostFrameCallback((_) =>
          DialogService.load(context, content: const IssueCompletedDialog()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => _addVehicleFunction(context),
              icon: SvgPicture.asset(
                SvgAssets.plus,
                height: AppSizes.s32.r,
                width: AppSizes.s32.r,
              ),
            ),
          ],
          elevation: 0,
          title: Text(
            AppStrings.myVehicles.tr(),
            style: smallHeadlineStyle(),
          ),
        ),
        body: _getContent(context),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    final cubit = BlocProvider.of<MyVehiclesCubit>(context);
    return BlocBuilder<MyVehiclesCubit, MyVehiclesState>(
      builder: (context, state) {
        if (state.fetchMyVehiclesStatus.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else if (state.fetchMyVehiclesStatus.isSuccess &&
            state.myVehicles!.isNotEmpty) {
          return Stack(
            children: [
              ListView.separated(
                controller: cubit.scrollController,
                padding: const EdgeInsets.all(AppValues.medium).r,
                separatorBuilder: (context, index) => CustomSpacers.medium(),
                shrinkWrap: true,
                itemCount: state.myVehicles?.length ?? 0,
                itemBuilder: (context, index) => VehicleListItem(
                  state.myVehicles![index],
                ),
              ),
              if (state.fetchMoreVehiclesStatus.isLoading)
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
              AppStrings.youDoNotHaveVehicles.tr(),
              textAlign: TextAlign.center,
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              AppStrings.youDidNotAddAnyVehicle.tr(),
              textAlign: TextAlign.center,
              style: grayBodyStyle(),
            ),
            CustomSpacers.large(),
            PrimaryButton.fullWidth(
              child: Text(AppStrings.addVehicle.tr()),
              onPressed: () => _addVehicleFunction(context),
            )
          ],
        ),
      ),
    );
  }
}
