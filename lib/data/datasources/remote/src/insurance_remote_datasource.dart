import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/data/datasources/remote/base/base_insurance_remote_datasource.dart';
import 'package:insurance_app/data/datasources/remote/helpers/index.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/data/responses/index.dart';

class InsuranceRemoteDatasource implements BaseInsuranceRemoteDatasource {
  final Dio _dio;
  final AppService _appService;

  InsuranceRemoteDatasource(this._dio, this._appService);

  @override
  Future<BasicResponse> calculateInsurancePrice(
      CalculateInsurancePriceRequest request) async {
    try {
      var response = await _dio.post(
        ApiConstants.calculateInsurancePrice,
        data: request.toBody(),
        queryParameters: request.toQueryParams(),
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

  @override
  Future<BasicResponse> pay(int insuranceId) async {
    try {
      var response = await _dio.put(
        '${ApiConstants.toggleInsurance}/$insuranceId',
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

  @override
  Future<BasicResponse> calculateInsurancePriceByVehicle(
      CalculateInsurancePriceByVehicleRequest request) async {
    final body = request.toMap();
    try {
      var response = await _dio.get(
        ApiConstants.calculateInsurancePriceByVehicle,
        data: body,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<InsuranceTypesResponse> getInsuranceTypes() async {
    try {
      var response = await _dio.get(ApiConstants.insuranceTypes,
          options: RemoteDatasourceHelpers.bearerToken(_appService.token));

      return InsuranceTypesResponse.fromMap({'insuranceTypes': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return InsuranceTypesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return InsuranceTypesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<InsurancesResponse> getMyInsurances({int? page}) async {
    try {
      var response = await _dio.get(
        ApiConstants.insurances,
        data: page != null ? {'page': page} : null,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return InsurancesResponse.fromMap(response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return InsurancesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return InsurancesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<IssueInsuranceResponse> issueInsurance(
      IssueInsuranceRequest request) async {
    final body = request.toMap();
    try {
      var response = await _dio.post(
        ApiConstants.insurances,
        data: body,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return IssueInsuranceResponse.fromMap(response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return IssueInsuranceResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return IssueInsuranceResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<InstallmentsResponse> getInsuranceInstallments(
      GetInsuranceInstallmentsRequest request) async {
    try {
      Response response = await _dio.post(
        ApiConstants.getInsuranceInstallments,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
        data: request.toMap(),
      );
      return InstallmentsResponse.fromMap(response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return InstallmentsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return InstallmentsResponse(message: AppStrings.genericError.tr());
    }
  }
}
