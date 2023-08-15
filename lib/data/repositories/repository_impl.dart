import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/mapper/city_mapper.dart';
import 'package:insurance_app/data/mapper/color_mapper.dart';
import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/entities/color.dart';
import 'package:insurance_app/domain/repositories/repository.dart';

import '../../app/app_strings.dart';
import '../datasources/remote_datasource.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  RepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, List<CityEntity>>> getCities() async {
    final response = await _remoteDataSource.getCities();
    if (response.cities == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.cities?.map((e) => e.toDomain()).toList() ?? []);
    }
  }

  @override
  Future<Either<Failure, List<ColorEntity>>> getColors() async {
    final response = await _remoteDataSource.getColors();
    if (response.colors == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.colors?.map((e) => e.toDomain()).toList() ?? []);
    }
  }
}
