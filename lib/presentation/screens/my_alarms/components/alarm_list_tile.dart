import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/alarm_status.dart';
import 'package:insurance_app/domain/entities/alarm.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

class AlarmListTile extends StatelessWidget {
  const AlarmListTile(this.alarm, {super.key});
  final AlarmEntity alarm;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [AppValues.boxShadow],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppValues.medium).r,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius:
                              BorderRadius.circular(AppValues.largeRadius)),
                      child: Image.asset(
                        ImageAssets.alarmClock,
                        width: AppSizes.s64.r,
                      ),
                    ),
                    CustomSpacers.mediumLarge(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alarm.alarmTypesEntity.name,
                          style: mediumSmallHeadlineStyle(),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.calendar,
                              height: AppSizes.s20.r,
                              width: AppSizes.s20.r,
                            ),
                            CustomSpacers.extraSmall(),
                            Text(
                              alarm.startDate,
                              style: smallGrayBodyStyle(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.calendar,
                              height: AppSizes.s20.r,
                              width: AppSizes.s20.r,
                            ),
                            CustomSpacers.extraSmall(),
                            Text(
                              alarm.endDate,
                              style: smallGrayBodyStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CustomSpacers.mediumLarge(),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      AppValues.medium.r * 2,
                  child: Wrap(
                    runSpacing: AppValues.medium,
                    spacing: AppValues.small,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.startsBefore.tr(),
                            style: extraSmallDarkGrayBodyStyle(),
                          ),
                          CustomSpacers.small(),
                          Text(
                            '${alarm.threshold} ${AppStrings.days.tr()}',
                            style: extraSmallHeadlineStyle(),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.status.tr(),
                            style: extraSmallDarkGrayBodyStyle(),
                          ),
                          CustomSpacers.small(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: AppSizes.s10.r,
                                height: AppSizes.s10.r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: alarm.status.getColor(),
                                ),
                              ),
                              CustomSpacers.small(),
                              Text(
                                alarm.status.name.tr(),
                                style: extraSmallHeadlineStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
