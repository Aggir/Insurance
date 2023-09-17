import 'package:insurance_app/data/requests/vehicle_requests.dart';
import 'package:insurance_app/data/responses/index.dart';

abstract class BaseVehicleRemoteDatasource {
  Future<VehicleBrandsResponse> getVehicleBrands();

  Future<VehicleCountriesResponse> getVehicleCountries();

  Future<VehicleOwnershipTypesResponse> getVehicleOwnershipTypes();

  Future<VehicleTypesResponse> getVehicleTypes();

  Future<VehicleModelsResponse> getVehicleModels(int vehicleBrandId);

  Future<BasicResponse> addVehicle(AddVehicleRequest request);

  Future<VehiclesResponse> getMyVehicles({int? page, bool isHidden = false});

  Future<BasicResponse> toggleIsVehicleHidden(int vehicleId);
}
