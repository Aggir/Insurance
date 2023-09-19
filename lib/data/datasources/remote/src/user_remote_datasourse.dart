import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/data/datasources/remote/base/base_user_remote_datasource.dart';
import 'package:insurance_app/data/datasources/remote/helpers/index.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';

class UserRemoteDatasource implements BaseUserRemoteDatasource {
  final Dio _dio;
  final AppService _appService;

  UserRemoteDatasource(this._dio, this._appService);

  @override
  Future<UserResponse> isLoggedIn() async {
    try {
      final String token = _appService.token;
      late UserResponse userResponse;
      if (token.isNotEmpty) {
        var response = await _dio.get(
          ApiConstants.me,
          options: RemoteDatasourceHelpers.bearerToken(token),
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
      return UserResponse(message: AppStrings.genericError.tr());
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
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return UserResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return UserResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<BasicResponse> signOut() async {
    final String token = _appService.token;
    try {
      await _dio.get(ApiConstants.logout,
          options: RemoteDatasourceHelpers.bearerToken(token));
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
      return BasicResponse(message: AppStrings.genericError.tr());
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
      RemoteDatasourceHelpers.checkTokenValidation(error);
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
      RemoteDatasourceHelpers.checkTokenValidation(error);
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
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<UserResponse> editProfile(EditProfileRequest request) async {
    try {
      final body = await request.toMap();
      var response = await _dio.post(
        ApiConstants.updateSelf,
        data: FormData.fromMap(body),
        options: RemoteDatasourceHelpers.bearerToken(
          _appService.token,
          header: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      final userResponse = UserResponse.fromMap({'user': response.data});
      return userResponse;
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
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
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return BasicResponse(data: response);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.changePassword(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<BasicResponse> deactivate() async {
    try {
      var response = await _dio.get(
        ApiConstants.deactivate,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
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
  Future<BasicResponse> sendVerifyPhoneOtp(String phone) async {
    try {
      Response response = await _dio.get(
        '${ApiConstants.sendPhoneOtp}/$phone',
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
  Future<BasicResponse> checkNationalId(String nationalId) async {
    try {
      final body = {'national_id': nationalId};
      var response = await _dio.post(
        ApiConstants.checkNational,
        data: body,
      );
      return BasicResponse(data: response.data == '1');
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }

  @override
  Future<BasicResponse> confirmEmail() async {
    try {
      final response = await _dio.get(
        ApiConstants.confirmEmail,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return BasicResponse(data: response);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError.tr());
    }
  }
}
