import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/alarm_requests.dart';
import 'package:insurance_app/domain/repositories/alarm_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class AddAlarmUsecase implements BaseUsecase<AddAlarmUsecaseInput, void> {
  final AlarmRepository _repository;

  AddAlarmUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(AddAlarmUsecaseInput input) async {
    return await _repository.addAlarm(AddAlarmRequest(
        startDate: input.startDate,
        endDate: input.endDate,
        threshold: input.remindTime,
        alarmTypeId: input.alarmTypeId,
        docFile: input.insurancePicture));
  }
}

class AddAlarmUsecaseInput {
  final String startDate;
  final String endDate;
  final int remindTime;
  final File insurancePicture;
  final int alarmTypeId;
  AddAlarmUsecaseInput({
    required this.startDate,
    required this.endDate,
    required this.remindTime,
    required this.insurancePicture,
    required this.alarmTypeId,
  });
}
