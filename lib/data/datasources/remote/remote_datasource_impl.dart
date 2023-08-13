import 'package:dio/dio.dart';

import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/data/datasources/remote/api_constants.dart';
import 'package:insurance_app/data/datasources/remote/api_error_handler.dart';
import 'package:insurance_app/data/datasources/remote_datasource.dart';
import 'package:insurance_app/data/requests/requests.dart';
import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _dio;
  final AppService _appService;
  RemoteDataSourceImpl(
    this._dio,
    this._appService,
  );

  Options _bearerToken(String token) {
    return Options(
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  @override
  Future<UserResponse> isLoggedIn() async {
    try {
      final String token = _appService.token;
      print('log');
      print(token);
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
      return UserResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
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
      print(response.data);
      final userResponse =
          UserResponse.fromMap(response.data as Map<String, dynamic>);
      _appService.token = userResponse.token ?? Constants.empty;

      return (userResponse);
    } on DioException catch (error) {
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
      print(token);
      return (BasicResponse());
    } on DioException catch (error) {
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
      print(request);
      final body = await request.toMap();

      Response response = await _dio.post(
        ApiConstants.signup,
        data: FormData.fromMap(body),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print(response.data);

      final userResponse =
          UserResponse.fromMap(response.data as Map<String, dynamic>);
      _appService.token = userResponse.token ?? Constants.empty;
      return (userResponse);
    } on DioException catch (error) {
      return UserResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (err) {
      return UserResponse(message: AppStrings.genericError);
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
      return BasicResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.auth(error));
    } catch (error) {
      return BasicResponse(message: AppStrings.genericError);
    }
  }
}
