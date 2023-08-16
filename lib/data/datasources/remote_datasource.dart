import 'package:insurance_app/data/requests/vehicle_requests.dart';
import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/cities_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';
import 'package:insurance_app/data/responses/colors_response.dart';
import 'package:insurance_app/data/responses/vehicle_brands_response.dart';
import 'package:insurance_app/data/responses/vehicle_countries_response.dart';
import 'package:insurance_app/data/responses/vehicle_models_response.dart';
import 'package:insurance_app/data/responses/vehicle_ownership_types_reponse.dart';
import 'package:insurance_app/data/responses/vehicle_types_reponse.dart';

import '../requests/user_requests.dart';

abstract class RemoteDataSource {
  Future<UserResponse> signIn(SignInRequest request);

  Future<BasicResponse> signOut();

  Future<UserResponse> signUp(SignUpRequest request);

  Future<UserResponse> isLoggedIn();

  Future<BasicResponse> checkUserInfo(CheckUserInfoRequest request);

  Future<BasicResponse> checkProofId(String proofId);

  Future<UserResponse> editProfile(EditProfileRequest request);

  Future<CitiesResponse> getCities();

  Future<ColorsResponse> getColors();

  Future<VehicleBrandsResponse> getVehicleBrands();

  Future<VehicleCountriesResponse> getVehicleCountries();

  Future<VehicleOwnershipTypesResponse> getVehicleOwnershipTypes();

  Future<VehicleTypesResponse> getVehicleTypes();

  Future<VehicleModelsResponse> getVehicleModels(int vehicleBrandId);

  Future<BasicResponse> addVehicle(AddVehicleRequest request);
}
