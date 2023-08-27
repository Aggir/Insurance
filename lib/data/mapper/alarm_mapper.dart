import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/alarm_status.dart';
import 'package:insurance_app/data/mapper/alarm_type_mapper.dart';
import 'package:insurance_app/data/models/alarm_model.dart';
import 'package:insurance_app/domain/entities/alarm.dart';
import 'package:insurance_app/domain/entities/alarm_type.dart';

extension AlarmModelExtension on AlarmModel? {
  AlarmEntity toDomain() => this == null
      ? AlarmEntity.empty()
      : AlarmEntity(
          this?.id ?? Constants.zero,
          this?.threshold ?? Constants.zero,
          this?.startDate ?? Constants.empty,
          this?.endDate ?? Constants.empty,
          this?.status?.toAlarmStatus() ?? AlarmStatus.expired,
          this?.alarmType.toDomain() ?? AlarmTypesEntity.empty(),
        );
}
