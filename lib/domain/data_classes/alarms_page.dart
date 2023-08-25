import 'package:equatable/equatable.dart';
import 'package:insurance_app/domain/entities/alarm.dart';
import 'package:insurance_app/domain/entities/meta.dart';

class AlarmsPage extends Equatable {
  final List<AlarmEntity> myAlarms;
  final MetaEntity meta;

  const AlarmsPage({
    required this.myAlarms,
    required this.meta,
  });

  @override
  List<Object> get props => [myAlarms, meta];
}
