import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetCitiesUsecase implements BaseUsecase<void, List<CityEntity>> {
  final Repository _repository;
  const GetCitiesUsecase(this._repository);
  @override
  Future<Either<Failure, List<CityEntity>>> execute(void input) async {
    return await _repository.getCities();
  }
}
