import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/entities/alarm_type.dart';
import 'package:insurance_app/domain/repositories/alarm_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetAlarmTypesUsecase
    implements BaseUsecase<void, List<AlarmTypesEntity>> {
  final AlarmRepository _repository;

  GetAlarmTypesUsecase(this._repository);

  @override
  Future<Either<Failure, List<AlarmTypesEntity>>> execute(void input) async {
    return await _repository.getAlarmTypes();
  }
}
