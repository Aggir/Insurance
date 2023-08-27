import 'package:dartz/dartz.dart';
import 'package:insurance_app/data/requests/vehicle_requests.dart';
import 'package:insurance_app/domain/data_classes/add_vehicle_form_data.dart';

import '../../app/failure.dart';
import '../data_classes/vehicles_page.dart';

abstract class VehicleRepository {
  Future<Either<Failure, AddVehicleFormData>> getVehicleFormOneData();

  Future<Either<Failure, AddVehicleFormData>> getVehicleModels(
      int vehicleBrandId);

  Future<Either<Failure, void>> addVehicle(AddVehicleRequest request);

  Future<Either<Failure, VehiclesPage>> getMyVehicles(
      {int? page, required bool isHidden});

  Future<Either<Failure, void>> toggleIsVehicleHidden(int vehicleId);
}
