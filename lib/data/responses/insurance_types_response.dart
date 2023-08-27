import 'package:insurance_app/data/models/insurance_type_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class InsuranceTypesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<InsuranceTypeModel>? insuranceTypes;

  InsuranceTypesResponse({
    this.code,
    this.message,
    this.insuranceTypes,
  });

  factory InsuranceTypesResponse.fromMap(Map<String, dynamic> map) {
    return InsuranceTypesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      insuranceTypes: map['insuranceTypes'] != null
          ? List<InsuranceTypeModel>.from(
              map['insuranceTypes']?.map((x) => InsuranceTypeModel.fromMap(x)))
          : null,
    );
  }
}
