import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/data_classes/alarms_page.dart';
import 'package:insurance_app/domain/repositories/alarm_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetMyAlarmsUsecase implements BaseUsecase<int?, AlarmsPage> {
  final AlarmRepository _repository;

  GetMyAlarmsUsecase(this._repository);
  @override
  Future<Either<Failure, AlarmsPage>> execute(int? input) async {
    return await _repository.getMyAlarms(page: input);
  }
}
