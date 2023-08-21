import 'dart:io';

import 'package:dio/dio.dart';
import 'package:insurance_app/data/requests/base_request.dart';

class AddAlarmRequest implements BaseRequest {
  final String startDate;
  final String endDate;
  final int threshold;
  final int alarmTypeId;
  final File docFile;
  AddAlarmRequest({
    required this.startDate,
    required this.endDate,
    required this.threshold,
    required this.alarmTypeId,
    required this.docFile,
  });

  AddAlarmRequest copyWith({
    String? startDate,
    String? endDate,
    int? threshold,
    int? alarmTypeId,
    File? docFile,
  }) {
    return AddAlarmRequest(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      threshold: threshold ?? this.threshold,
      alarmTypeId: alarmTypeId ?? this.alarmTypeId,
      docFile: docFile ?? this.docFile,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'threshold': threshold,
      'alarm_type_id': alarmTypeId,
      'doc_file': await MultipartFile.fromFile(docFile.path)
    };
  }
}
