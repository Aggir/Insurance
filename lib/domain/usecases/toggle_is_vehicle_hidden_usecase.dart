import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/vehicle_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class ToggleIsVehicleHiddenUsecase implements BaseUsecase<int, void> {
  final VehicleRepository _repository;

  ToggleIsVehicleHiddenUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(int vehicleId) async {
    return await _repository.toggleIsVehicleHidden(vehicleId);
  }
}
