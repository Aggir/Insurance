import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/blocs/my_alarms/my_alarms_cubit.dart';
import 'package:insurance_app/presentation/screens/my_alarms/components/alarm_list_tile.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

class MyAlarmsScreen extends StatefulWidget {
  const MyAlarmsScreen({super.key});

  @override
  State<MyAlarmsScreen> createState() => _MyAlarmsScreenState();
}

class _MyAlarmsScreenState extends State<MyAlarmsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        title: AppStrings.myAlarms.tr(),
        backButton: () {
          context.pop();
        },
      ),
      body: _getContent(context),
    );
  }

  @override
  void initState() {
    BlocProvider.of<MyAlarmsCubit>(context).init();
    super.initState();
  }

  Widget _getContent(BuildContext context) {
    final cubit = BlocProvider.of<MyAlarmsCubit>(context);
    return BlocBuilder<MyAlarmsCubit, MyAlarmsState>(
      builder: (context, state) {
        if (state.fetchMyAlarmsStatus.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else if (state.fetchMyAlarmsStatus.isSuccess &&
            state.myAlarms!.isNotEmpty) {
          return Stack(
            children: [
              ListView.separated(
                controller: cubit.scrollController,
                padding: const EdgeInsets.all(AppValues.medium).r,
                separatorBuilder: (context, index) => CustomSpacers.medium(),
                shrinkWrap: true,
                itemCount: state.myAlarms?.length ?? 0,
                itemBuilder: (context, index) =>
                    AlarmListTile(state.myAlarms![index]),
              ),
              if (state.fetchMyAlarmsStatus.isLoading)
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
              AppStrings.youDoNotHaveAnyAlarmsYet.tr(),
              textAlign: TextAlign.center,
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              AppStrings.youCanAddAlarms.tr(),
              textAlign: TextAlign.center,
              style: grayBodyStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
