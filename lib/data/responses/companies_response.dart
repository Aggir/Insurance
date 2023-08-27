import 'package:insurance_app/data/models/company_model.dart';
import 'package:insurance_app/data/models/meta_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class CompaniesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<CompanyModel>? companies;

  MetaModel? meta;

  CompaniesResponse({
    this.code,
    this.message,
    this.companies,
    this.meta,
  });

  factory CompaniesResponse.fromMap(Map<String, dynamic> map) {
    return CompaniesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      companies: map['data'] != null
          ? List<CompanyModel>.from(
              map['data']?.map((x) => CompanyModel.fromMap(x)))
          : null,
      meta: map['meta'] != null ? MetaModel.fromMap(map['meta']) : null,
    );
  }
}
