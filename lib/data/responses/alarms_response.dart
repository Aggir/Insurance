import 'package:insurance_app/data/models/alarm_model.dart';
import 'package:insurance_app/data/models/meta_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class AlarmsResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<AlarmModel>? alarms;

  MetaModel? meta;

  AlarmsResponse({
    this.code,
    this.message,
    this.alarms,
    this.meta,
  });

  factory AlarmsResponse.fromMap(Map<String, dynamic> map) {
    return AlarmsResponse(
        code: map['code']?.toInt(),
        message: map['message'],
        alarms: map['data'] != null
            ? List<AlarmModel>.from(
                map['data']?.map((x) => AlarmModel.fromMap(x)))
            : null,
        meta: map['meta'] != null ? MetaModel.fromMap(map['meta']) : null);
  }

  @override
  String toString() {
    return 'VehiclesResponse(code: $code, message: $message, vehicles: ${alarms?.length}, meta: $meta)';
  }
}
