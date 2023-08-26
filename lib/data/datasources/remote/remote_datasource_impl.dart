import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/data/datasources/remote/api_constants.dart';
import 'package:insurance_app/data/datasources/remote/api_error_handler.dart';
import 'package:insurance_app/data/datasources/remote_datasource.dart';
import 'package:insurance_app/data/requests/alarm_requests.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/data/requests/vehicle_requests.dart';
import 'package:insurance_app/data/responses/alarm_types_response.dart';
import 'package:insurance_app/data/responses/alarms_reponse.dart';
import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/branches_response.dart';
import 'package:insurance_app/data/responses/cities_response.dart';
import 'package:insurance_app/data/responses/colors_response.dart';
import 'package:insurance_app/data/responses/companies_response.dart';
import 'package:insurance_app/data/responses/insurance_types_response.dart';
import 'package:insurance_app/data/responses/insurances_response.dart';
import 'package:insurance_app/data/responses/notifications_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';
import 'package:insurance_app/data/responses/vehicle_brands_response.dart';
import 'package:insurance_app/data/responses/vehicle_countries_response.dart';
import 'package:insurance_app/data/responses/vehicle_models_response.dart';
import 'package:insurance_app/data/responses/vehicle_ownership_types_reponse.dart';
import 'package:insurance_app/data/responses/vehicle_types_reponse.dart';
import 'package:insurance_app/data/responses/vehicles_response.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';

//TODO: REFACTOR IT.
class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _dio;
  final AppService _appService;
  RemoteDataSourceImpl(
    this._dio,
    this._appService,
  );

  Options _bearerToken(String token, {Map<String, String>? header}) {
    print(token);
    return Options(
      headers: header == null
          ? {
              'Authorization': 'Bearer $token',
            }
          : {'Authorization': 'Bearer $token', ...header},
    );
  }

  void _checkTokenValidation(DioException error) {
    final String? message = error.response?.data['message'];
    if (message != null && message.contains('Unauthenticated.')) {
      instance<UserCubit>().logout();
    }
  }

  @override
  Future<UserResponse> isLoggedIn() async {
    try {
      final String token = _appService.token;
      late UserResponse userResponse;
      if (token.isNotEmpty) {
        var response = await _dio.get(
          ApiConstants.me,
          options: _bearerToken(token),
        );
        userResponse =
            UserResponse.fromMap(response.data as Map<String, dynamic>);
      } else {
        userResponse = UserResponse();
      }
      if (userResponse.user == null) {
        _appService.token = Constants.empty;
      }
      return (userResponse);
    } on DioException catch (error) {
      _appService.token = Constants.empty;
      return UserResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      _appService.token = Constants.empty;
      return UserResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<UserResponse> signIn(SignInRequest request) async {
    try {
      final body = request.toMap();
      var response = await _dio.post(
        ApiConstants.signin,
        data: body,
      );
      final userResponse =
          UserResponse.fromMap(response.data as Map<String, dynamic>);
      _appService.token = userResponse.token ?? Constants.empty;

      return (userResponse);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return UserResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return UserResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> signOut() async {
    final String token = _appService.token;
    try {
      await _dio.get(ApiConstants.logout, options: _bearerToken(token));
      _appService.token = Constants.empty;
      return (BasicResponse());
    } on DioException catch (error) {
      // Todo: use response code instead of message
      final String? message = error.response?.data['message'];
      if (message != null && message.contains('Unauthenticated.')) {
        return (BasicResponse());
      }
      _appService.token = token;
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      _appService.token = token;
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<UserResponse> signUp(SignUpRequest request) async {
    try {
      final body = await request.toMap();
      Response response = await _dio.post(
        ApiConstants.signup,
        data: FormData.fromMap(body),
        options: Options(
          sendTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      final userResponse =
          UserResponse.fromMap(response.data as Map<String, dynamic>);
      _appService.token = userResponse.token ?? Constants.empty;
      return (userResponse);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return UserResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (err) {
      return UserResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<BasicResponse> checkUserInfo(CheckUserInfoRequest request) async {
    try {
      final body = request.toMap();
      var response = await _dio.post(
        ApiConstants.check,
        data: body,
      );
      return BasicResponse(data: response.data == '1');
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> checkProofId(String proofId) async {
    try {
      final body = {'proof_id': proofId};
      var response = await _dio.post(
        ApiConstants.checkDoc,
        data: body,
      );
      return BasicResponse(data: response.data == '1');
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<CitiesResponse> getCities() async {
    try {
      var response = await _dio.get(
        ApiConstants.cities,
        options: _bearerToken(_appService.token),
      );
      return CitiesResponse.fromMap({'cities': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
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
        options: _bearerToken(_appService.token),
      );
      return ColorsResponse.fromMap({'colors': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return ColorsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return ColorsResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<VehicleBrandsResponse> getVehicleBrands() async {
    try {
      var response = await _dio.get(
        ApiConstants.vehicleBrands,
        options: _bearerToken(_appService.token),
      );
      return VehicleBrandsResponse.fromMap({'vehicleBrands': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
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
        options: _bearerToken(_appService.token),
      );
      return VehicleCountriesResponse.fromMap(
          {'vehicleCountries': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
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
        options: _bearerToken(_appService.token),
      );
      return VehicleModelsResponse.fromMap({'vehicleModels': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
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
        options: _bearerToken(_appService.token),
      );
      return VehicleOwnershipTypesResponse.fromMap(
          {'vehicleOwnershipTypes': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
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
        options: _bearerToken(_appService.token),
      );
      return VehicleTypesResponse.fromMap({'vehicleTypes': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
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
          options: _bearerToken(_appService.token, header: {
            'Content-Type': 'multipart/form-data',
          }));

      return BasicResponse(data: response);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<UserResponse> editProfile(EditProfileRequest request) async {
    try {
      final body = await request.toMap();
      var response = await _dio.post(
        ApiConstants.updateSelf,
        data: FormData.fromMap(body),
        options: _bearerToken(
          _appService.token,
          header: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      final userResponse = UserResponse.fromMap({'user': response.data});
      return userResponse;
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return UserResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return UserResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> changePassword(ChangePasswordRequest request) async {
    try {
      final body = request.toMap();
      Response response = await _dio.post(
        ApiConstants.changePassword,
        data: body,
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.changePassword(error));
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
          options: _bearerToken(_appService.token));
      return VehiclesResponse.fromMap(response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return VehiclesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return VehiclesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<CompaniesResponse> getCompanies(int? page) async {
    try {
      var response = await _dio.get(ApiConstants.companies,
          data: page != null ? {'page': page} : null,
          options: _bearerToken(_appService.token));
      return CompaniesResponse.fromMap(response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return CompaniesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return CompaniesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BranchesResponse> getCompanyBranches(int? companyId) async {
    try {
      var response = await _dio.get('${ApiConstants.branches}/$companyId',
          options: _bearerToken(_appService.token));

      return BranchesResponse.fromMap({'branches': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BranchesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BranchesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<InsuranceTypesResponse> getInsuranceTypes() async {
    try {
      var response = await _dio.get(ApiConstants.insuranceTypes,
          options: _bearerToken(_appService.token));

      return InsuranceTypesResponse.fromMap({'insuranceTypes': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return InsuranceTypesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return InsuranceTypesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> calculateInsurancePrice(
      CalculateInsurancePriceRequest request) async {
    final body = request.toMap();
    try {
      var response = await _dio.get(
        ApiConstants.calculateInsurancePrice,
        data: body,
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> issueInsurance(IssueInsuranceRequest request) async {
    final body = request.toMap();
    try {
      var response = await _dio.post(
        ApiConstants.insurances,
        data: body,
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: int.parse(response.data));
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> deactivate() async {
    try {
      var response = await _dio.get(
        ApiConstants.deactivate,
        options: _bearerToken(_appService.token),
      );
      _appService.token = Constants.empty;
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<BasicResponse> forgotPassword(String email) async {
    try {
      var response = await _dio.get("${ApiConstants.resetPassword}/$email");
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<BasicResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      var response = await _dio.post(
        "${ApiConstants.validateResetOtp}?email=${request.email}&otp=${request.otp}",
        data: request.toBody(),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<BasicResponse> verifyForgotPasswordOtp(
      VerifyOtpForgotPasswordRequest request) async {
    try {
      var response = await _dio.post(
        "${ApiConstants.validateResetOtp}?email=${request.email}&otp=${request.otp}",
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.otpVerification(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<InsurancesResponse> getMyInsurances({int? page}) async {
    try {
      var response = await _dio.get(
        ApiConstants.insurances,
        data: page != null ? {'page': page} : null,
        options: _bearerToken(_appService.token),
      );
      return InsurancesResponse.fromMap(response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return InsurancesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return InsurancesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> pay(int insuranceId) async {
    try {
      var response = await _dio.put(
        '${ApiConstants.toggleInsurance}/$insuranceId',
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<AlarmTypesResponse> getAlarmTypes() async {
    try {
      Response response = await _dio.get(
        ApiConstants.alarmTypes,
        options: _bearerToken(_appService.token),
      );
      return AlarmTypesResponse.fromMap({'alarmTypes': response.data});
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return AlarmTypesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return AlarmTypesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> addAlarm(AddAlarmRequest request) async {
    try {
      final body = await request.toMap();

      Response response = await _dio.post(
        ApiConstants.alarms,
        data: FormData.fromMap(body),
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> toggleIsVehicleHidden(int vehicleId) async {
    try {
      Response response = await _dio.put(
        '${ApiConstants.toggleIsVehicleHidden}/$vehicleId',
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<AlarmsResponse> getMyAlarms({int? page}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.alarms,
        options: _bearerToken(_appService.token),
      );
      return AlarmsResponse.fromMap(response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return AlarmsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return AlarmsResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<NotificationsResponse> getNotifications() async {
    try {
      Response response = await _dio.get(
        ApiConstants.notifications,
        options: _bearerToken(_appService.token),
      );
      return NotificationsResponse.fromMap(response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return NotificationsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return NotificationsResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> toggleNotificationsIsSeen() async {
    try {
      Response response = await _dio.get(
        ApiConstants.notificationToggleSeen,
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> toggleNotificationIsRead(int id) async {
    try {
      Response response = await _dio.get(
        '${ApiConstants.notificationToggleRead}/$id',
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> countUnseenNotifications() async {
    try {
      Response response = await _dio.get(
        ApiConstants.notificationCountUnseen,
        options: _bearerToken(_appService.token),
      );
      return BasicResponse(data: response.data);
    } on DioException catch (error) {
      _checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }
}
