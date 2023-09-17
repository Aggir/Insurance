import 'package:insurance_app/data/requests/alarm_requests.dart';
import 'package:insurance_app/data/responses/index.dart';

abstract class BaseAlarmRemoteDatasource {
  Future<AlarmTypesResponse> getAlarmTypes();

  Future<BasicResponse> addAlarm(AddAlarmRequest request);

  Future<AlarmsResponse> getMyAlarms({int? page});
}
