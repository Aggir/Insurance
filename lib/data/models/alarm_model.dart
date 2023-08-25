import 'package:insurance_app/data/models/alarm_type_model.dart';

class AlarmModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? threshold;
  final String? startDate;
  final String? endDate;
  final String? docFile;
  final String? status;
  final AlarmTypeModel? alarmType;
  final int? userId;
  final int? insuranceId;

  AlarmModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.threshold,
    this.startDate,
    this.endDate,
    this.docFile,
    this.status,
    this.alarmType,
    this.userId,
    this.insuranceId,
  });

  factory AlarmModel.fromMap(Map<String, dynamic> map) {
    return AlarmModel(
      id: map['id'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      threshold: map['threshold'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      docFile: map['doc_file'],
      status: map['status'],
      alarmType: map['alarm_type'] != null
          ? AlarmTypeModel.fromMap(map['alarm_type'])
          : null,
      userId: map['user_id'],
      insuranceId: map['insurance_id'],
    );
  }
}
