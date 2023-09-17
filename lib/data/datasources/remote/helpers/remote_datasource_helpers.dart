import 'package:dio/dio.dart';

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
}
