import 'package:insurance_app/data/responses/base_response.dart';

class BasicResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  dynamic data;

  BasicResponse({
    this.code,
    this.message,
    this.data,
  });
}
