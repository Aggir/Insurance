import 'package:insurance_app/data/models/insurance_model.dart';
import 'package:insurance_app/data/models/meta_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class InsurancesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<InsuranceModel>? insurances;

  MetaModel? meta;

  InsurancesResponse({
    this.code,
    this.message,
    this.insurances,
    this.meta,
  });

  factory InsurancesResponse.fromMap(Map<String, dynamic> map) {
    return InsurancesResponse(
        code: map['code']?.toInt(),
        message: map['message'],
        insurances: map['data'] != null
            ? List<InsuranceModel>.from(
                map['data']?.map((x) => InsuranceModel.fromMap(x)))
            : null,
        meta: map['meta'] != null ? MetaModel.fromMap(map['meta']) : null);
  }

  @override
  String toString() {
    return 'insurancesResponse(code: $code, message: $message, insurances: ${insurances?.length}, meta: $meta)';
  }
}
