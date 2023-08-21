import 'package:insurance_app/data/models/alarm_type_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class AlarmTypesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<AlarmTypeModel>? alarmTypes;

  AlarmTypesResponse({
    this.code,
    this.message,
    this.alarmTypes,
  });

  factory AlarmTypesResponse.fromMap(Map<String, dynamic> map) {
    return AlarmTypesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      alarmTypes: map['alarmTypes'] != null
          ? List<AlarmTypeModel>.from(
              map['alarmTypes']?.map((x) => AlarmTypeModel.fromMap(x)))
          : null,
    );
  }
}
