import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/data/datasources/remote/base/base_vehicle_remote_datasource.dart';
import 'package:insurance_app/data/datasources/remote/helpers/index.dart';
import 'package:insurance_app/data/requests/vehicle_requests.dart';
import 'package:insurance_app/data/responses/index.dart';

class VehicleRemoteDatasource implements BaseVehicleRemoteDatasource {
  final Dio _dio;
  final AppService _appService;

  VehicleRemoteDatasource(this._dio, this._appService);

  @override
  Future<VehicleBrandsResponse> getVehicleBrands() async {
    try {
      var response = await _dio.get(
        ApiConstants.vehicleBrands,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return VehicleBrandsResponse.fromMap({'vehicleBrands': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return VehicleBrandsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return VehicleBrandsResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<VehicleCountriesResponse> getVehicleCountries() async {
    try {
      var response = await _dio.get(
        ApiConstants.vehicleCountries,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return VehicleCountriesResponse.fromMap(
          {'vehicleCountries': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return VehicleCountriesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return VehicleCountriesResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<VehicleModelsResponse> getVehicleModels(int vehicleBrandId) async {
    try {
      var response = await _dio.get(
        "${ApiConstants.vehicleModels}/$vehicleBrandId",
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return VehicleModelsResponse.fromMap({'vehicleModels': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return VehicleModelsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return VehicleModelsResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<VehicleOwnershipTypesResponse> getVehicleOwnershipTypes() async {
    try {
      var response = await _dio.get(
        ApiConstants.vehicleOwnershipTypes,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return VehicleOwnershipTypesResponse.fromMap(
          {'vehicleOwnershipTypes': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return VehicleOwnershipTypesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return VehicleOwnershipTypesResponse(
          message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<VehicleTypesResponse> getVehicleTypes() async {
    try {
      var response = await _dio.get(
        ApiConstants.vehicleTypes,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return VehicleTypesResponse.fromMap({'vehicleTypes': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return VehicleTypesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return VehicleTypesResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<BasicResponse> addVehicle(AddVehicleRequest request) async {
    try {
      final body = await request.toMap();
      var response = await _dio.post(ApiConstants.vehicles,
          data: FormData.fromMap(body),
          options:
              RemoteDatasourceHelpers.bearerToken(_appService.token, header: {
            'Content-Type': 'multipart/form-data',
          }));
      return BasicResponse(data: response);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<VehiclesResponse> getMyVehicles(
      {int? page, bool isHidden = false}) async {
    try {
      var response = await _dio.get(ApiConstants.vehicles,
          data: {'page': page, 'is_hidden': isHidden ? isHidden : null},
          options: RemoteDatasourceHelpers.bearerToken(_appService.token));
      return VehiclesResponse.fromMap(response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return VehiclesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return VehiclesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> toggleIsVehicleHidden(int vehicleId) async {
    try {
      Response response = await _dio.put(
        '${ApiConstants.toggleIsVehicleHidden}/$vehicleId',
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }
}
