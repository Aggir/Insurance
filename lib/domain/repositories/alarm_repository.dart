import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/alarm_requests.dart';
import 'package:insurance_app/domain/data_classes/alarms_page.dart';
import 'package:insurance_app/domain/entities/alarm_type.dart';

abstract class AlarmRepository {
  Future<Either<Failure, List<AlarmTypesEntity>>> getAlarmTypes();

  Future<Either<Failure, void>> addAlarm(AddAlarmRequest request);

  Future<Either<Failure, AlarmsPage>> getMyAlarms({int? page});
}
