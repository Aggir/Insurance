import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/data/datasources/remote/base/base_generic_remote_datasource.dart';
import 'package:insurance_app/data/datasources/remote/helpers/index.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/data/responses/index.dart';

class GenericRemoteDatasource implements BaseGenericRemoteDatasource {
  final Dio _dio;
  final AppService _appService;

  GenericRemoteDatasource(this._dio, this._appService);

  @override
  Future<BasicResponse> countUnseenNotifications() async {
    try {
      Response response = await _dio.get(
        ApiConstants.notificationCountUnseen,
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
  Future<CitiesResponse> getCities() async {
    try {
      var response = await _dio.get(
        ApiConstants.cities,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return CitiesResponse.fromMap({'cities': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return CitiesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return CitiesResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<ColorsResponse> getColors() async {
    try {
      var response = await _dio.get(
        ApiConstants.colors,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return ColorsResponse.fromMap({'colors': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return ColorsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return ColorsResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<CompaniesResponse> getCompanies(int? page) async {
    try {
      var response = await _dio.get(ApiConstants.companies,
          data: page != null ? {'page': page} : null,
          options: RemoteDatasourceHelpers.bearerToken(_appService.token));
      return CompaniesResponse.fromMap(response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return CompaniesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return CompaniesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<CompaniesPricesResponse> getCompaniesPrices(
      CompaniesPricesRequest request) async {
    try {
      Response response = await _dio.get(
        ApiConstants.companiesPrices,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
        queryParameters: request.toMap(),
      );
      return CompaniesPricesResponse.fromMap(
          {'companiesPrices': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return CompaniesPricesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return CompaniesPricesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BranchesResponse> getCompanyBranches(int? companyId) async {
    try {
      var response = await _dio.get('${ApiConstants.branches}/$companyId',
          options: RemoteDatasourceHelpers.bearerToken(_appService.token));

      return BranchesResponse.fromMap({'branches': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BranchesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BranchesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<NotificationsResponse> getNotifications() async {
    try {
      Response response = await _dio.get(
        ApiConstants.notifications,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return NotificationsResponse.fromMap(response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return NotificationsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return NotificationsResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> toggleNotificationIsRead(int id) async {
    try {
      Response response = await _dio.get(
        '${ApiConstants.notificationToggleRead}/$id',
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
  Future<BasicResponse> toggleNotificationsIsSeen() async {
    try {
      Response response = await _dio.get(
        ApiConstants.notificationToggleSeen,
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
  Future<BasicResponse> countCompanies() async {
    try {
      Response response = await _dio.get(
        ApiConstants.companiesCount,
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
