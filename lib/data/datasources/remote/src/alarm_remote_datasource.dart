import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/data/datasources/remote/base/base_alarm_remote_datasource.dart';
import 'package:insurance_app/data/datasources/remote/helpers/index.dart';
import 'package:insurance_app/data/requests/alarm_requests.dart';
import 'package:insurance_app/data/responses/alarm_types_response.dart';
import 'package:insurance_app/data/responses/alarms_response.dart';
import 'package:insurance_app/data/responses/basic_response.dart';

class AlarmRemoteDatasource implements BaseAlarmRemoteDatasource {
  final Dio _dio;
  final AppService _appService;

  AlarmRemoteDatasource(this._dio, this._appService);

  @override
  Future<BasicResponse> addAlarm(AddAlarmRequest request) async {
    try {
      final body = await request.toMap();

      Response response = await _dio.post(
        ApiConstants.alarms,
        data: FormData.fromMap(body),
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
  Future<AlarmTypesResponse> getAlarmTypes() async {
    try {
      Response response = await _dio.get(
        ApiConstants.alarmTypes,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return AlarmTypesResponse.fromMap({'alarmTypes': response.data});
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return AlarmTypesResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return AlarmTypesResponse(message: AppStrings.genericError);
    }
  }

  @override
  Future<AlarmsResponse> getMyAlarms({int? page}) async {
    try {
      Response response = await _dio.get(
        ApiConstants.alarms,
        options: RemoteDatasourceHelpers.bearerToken(_appService.token),
      );
      return AlarmsResponse.fromMap(response.data);
    } on DioException catch (error) {
      RemoteDatasourceHelpers.checkTokenValidation(error);
      return AlarmsResponse(
          code: error.response?.statusCode,
          message: ApiErrorHandler.generic(error));
    } catch (error) {
      return AlarmsResponse(message: AppStrings.genericError);
    }
  }
}
