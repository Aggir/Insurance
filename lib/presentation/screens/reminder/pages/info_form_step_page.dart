import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackbars.dart';

import '../../../../app/router/routes.dart';
import '../../../blocs/add_reminder/add_reminder_cubit.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_form_field_date_picker.dart';
import '../../../widgets/page_content_padding.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

class ReminderInfoFormStepPage extends StatefulWidget {
  const ReminderInfoFormStepPage({super.key});

  @override
  State<ReminderInfoFormStepPage> createState() =>
      _ReminderInfoFormStepPageState();
}

class _ReminderInfoFormStepPageState extends State<ReminderInfoFormStepPage> {
  void _nextButtonFunction(BuildContext context) {
    if (BlocProvider.of<AddReminderCubit>(context).confirmStepOne()) {
      context.go(AppScreen.reminderInsuranceInfoStep.toPath);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => DialogService.loadLoadingDialog(context));
    BlocProvider.of<AddReminderCubit>(context).fetchAlarmTypes();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            AppValues.appBarHeight -
            AppSizes.s30.r,
        child: PageContentPadding(
          child: Column(
            children: [
              Container(
                height: AppSizes.s104.r,
                width: AppSizes.s104.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(ImageAssets.alarmClock),
              ),
              CustomSpacers.large(),
              Text(
                AppStrings.insurancePolicyData.tr(),
                style: largeHeadlineStyle(),
              ),
              CustomSpacers.medium(),
              Text(
                AppStrings.reminderAboutExpirationDateDescription.tr(),
                style: darkGrayBodyStyle(),
                textAlign: TextAlign.center,
              ),
              CustomSpacers.extraLarge(),
              _form(context),
              const Spacer(),
              PrimaryButton.fullWidth(
                onPressed: () => _nextButtonFunction(context),
                child: Text(AppStrings.next.tr()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _form(context) {
    final cubit = BlocProvider.of<AddReminderCubit>(context);
    return Form(
        key: cubit.formKey,
        child: Column(
          children: [
            BlocConsumer<AddReminderCubit, AddReminderState>(
              listenWhen: (previous, current) =>
                  previous.fetchAlarmTypesStatus !=
                  current.fetchAlarmTypesStatus,
              listener: (context, state) {
                if (state.fetchAlarmTypesStatus.isFailure) {
                  DialogService.dispose();
                  SnackBars.error(context, state.fetchAlarmTypesErrorMessage!);
                } else if (state.fetchAlarmTypesStatus.isSuccess) {
                  DialogService.dispose();
                }
              },
              builder: (context, state) {
                return CustomDropDownField(
                  onChanged: (value) {
                    cubit.setSelectedType(int.parse(value));
                  },
                  hintText: AppStrings.selectAlarmType.tr(),
                  items: state.alarmTypes == null
                      ? []
                      : state.alarmTypes!
                          .map(
                            (alarmType) => DropdownMenuItem(
                              value: alarmType.id.toString(),
                              child: Text(
                                alarmType.name,
                                style: bodyStyle(),
                              ),
                            ),
                          )
                          .toList(),
                );
              },
            ),
            CustomSpacers.medium(),
            CustomDropDownField(
              onChanged: (value) {
                cubit.setSelectedTime(int.parse(value));
              },
              hintText: AppStrings.selectTheAppropriateAlarm.tr(),
              items: DUMMY.remindMeOptions
                  .map(
                    (type) => DropdownMenuItem(
                      value: type.days.toString(),
                      child: Text(
                        type.name,
                        style: bodyStyle(),
                      ),
                    ),
                  )
                  .toList(),
            ),
            CustomSpacers.medium(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: CustomFormFieldDatePicker(
                  onChanged: (_) {
                    cubit.setEndDate();
                  },
                  controller: cubit.startDateController,
                  hintText: AppStrings.startDate.tr(),
                  lastDate: DateTime(DateTime.now().year + 10),
                )),
                CustomSpacers.medium(),
                Flexible(
                    child: CustomFormFieldDatePicker(
                  controller: cubit.endDateController,
                  enabled: false,
                  hintText: AppStrings.endDate.tr(),
                )),
              ],
            )
          ],
        ));
  }
}
