import 'package:dartz/dartz.dart';

import 'package:insurance_app/domain/entities/vehicles_page.dart';
import 'package:insurance_app/domain/repositories/vehicle_repository.dart';

import '../../app/failure.dart';
import 'base_usecase.dart';

class GetMyVehiclesUsecase implements BaseUsecase<int?, VehiclesPageEntity> {
  final VehicleRepository _repository;
  const GetMyVehiclesUsecase(this._repository);
  @override
  Future<Either<Failure, VehiclesPageEntity>> execute(int? page) async {
    return await _repository.getMyVehicles(page: page);
  }
}
