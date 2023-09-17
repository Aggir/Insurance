import 'package:dio/dio.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';

class RemoteDatasourceHelpers {
  static Options bearerToken(String token, {Map<String, String>? header}) {
    print(token);
    return Options(
      headers: header == null
          ? {
              'Authorization': 'Bearer $token',
            }
          : {'Authorization': 'Bearer $token', ...header},
    );
  }

  static void checkTokenValidation(DioException error) {
    if (error.response?.data is Map &&
        error.response?.data['message'] is String) {
      final String? message = error.response?.data['message'];
      if (message != null && message.contains('Unauthenticated.')) {
        instance<UserCubit>().logout();
      }
    }
  }
}
