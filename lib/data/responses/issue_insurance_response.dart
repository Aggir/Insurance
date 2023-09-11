import 'package:insurance_app/data/models/insurance_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class IssueInsuranceResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  InsuranceModel? insurance;

  IssueInsuranceResponse({
    this.code,
    this.message,
    this.insurance,
  });

  factory IssueInsuranceResponse.fromMap(Map<String, dynamic> map) {
    return IssueInsuranceResponse(
        code: map['code']?.toInt(),
        message: map['message'],
        insurance: InsuranceModel.fromMap(map));
  }
}
