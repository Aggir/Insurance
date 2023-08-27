import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/alarm_status.dart';
import 'package:insurance_app/domain/entities/alarm_type.dart';

class AlarmEntity extends Equatable {
  final int id;
  final int threshold;
  final String startDate;
  final String endDate;
  final AlarmTypesEntity alarmTypesEntity;
  final AlarmStatus status;

  const AlarmEntity(
    this.id,
    this.threshold,
    this.startDate,
    this.endDate,
    this.status,
    this.alarmTypesEntity,
  );

  factory AlarmEntity.empty() => AlarmEntity(
        Constants.zero,
        Constants.zero,
        Constants.empty,
        Constants.empty,
        AlarmStatus.expired,
        AlarmTypesEntity.empty(),
      );

  @override
  List<Object> get props {
    return [
      id,
      threshold,
      startDate,
      endDate,
      alarmTypesEntity,
      status,
    ];
  }
}
