import 'package:dartz/dartz.dart';
import 'package:insurance_app/domain/data_classes/add_vehicle_form_data.dart';
import 'package:insurance_app/domain/repositories/vehicle_repository.dart';

import '../../app/failure.dart';
import 'base_usecase.dart';

class GetAddVehicleFormDataUsecase
    implements BaseUsecase<void, AddVehicleFormData> {
  final VehicleRepository _repository;
  const GetAddVehicleFormDataUsecase(this._repository);
  @override
  Future<Either<Failure, AddVehicleFormData>> execute(void input) async {
    return await _repository.getVehicleFormOneData();
  }
}
