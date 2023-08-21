import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/datasources/remote_datasource.dart';
import 'package:insurance_app/data/mapper/alarm_type_mapper.dart';
import 'package:insurance_app/data/requests/alarm_requests.dart';
import 'package:insurance_app/domain/entities/alarm_type.dart';
import 'package:insurance_app/domain/repositories/alarm_repository.dart';

class AlarmRepositoryImpl implements AlarmRepository {
  final RemoteDataSource _remoteDataSource;

  AlarmRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<AlarmTypesEntity>>> getAlarmTypes() async {
    final response = await _remoteDataSource.getAlarmTypes();
    if (response.message != null) {
      return Left(
        Failure(
          response.code ?? 0,
          response.message ?? AppStrings.genericError.tr(),
        ),
      );
    } else {
      return Right(
        response.alarmTypes?.map((e) => e.toDomain()).toList() ?? [],
      );
    }
  }

  @override
  Future<Either<Failure, void>> addAlarm(AddAlarmRequest request) async {
    final response = await _remoteDataSource.addAlarm(request);
    if (response.message != null) {
      return Left(
        Failure(
          response.code ?? 0,
          response.message ?? AppStrings.genericError.tr(),
        ),
      );
    } else {
      return const Right(null);
    }
  }
}
