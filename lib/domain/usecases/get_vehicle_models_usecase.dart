import 'package:dartz/dartz.dart';

import '../../app/failure.dart';
import '../data_classes/add_vehicle_form_data.dart';
import '../repositories/vehicle_repository.dart';
import 'base_usecase.dart';

class GetVehicleModelsUsecase implements BaseUsecase<int, AddVehicleFormData> {
  final VehicleRepository _repository;
  const GetVehicleModelsUsecase(this._repository);
  @override
  Future<Either<Failure, AddVehicleFormData>> execute(
      int vehicleBrandId) async {
    return await _repository.getVehicleModels(vehicleBrandId);
  }
}
