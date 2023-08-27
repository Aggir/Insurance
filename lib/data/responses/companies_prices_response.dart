import 'package:insurance_app/data/models/company_price_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class CompaniesPricesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<CompanyPriceModel>? companiesPrices;

  CompaniesPricesResponse({
    this.code,
    this.message,
    this.companiesPrices,
  });

  factory CompaniesPricesResponse.fromMap(Map<String, dynamic> map) {
    return CompaniesPricesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      companiesPrices: map['companiesPrices'] != null
          ? List<CompanyPriceModel>.from(
              map['companiesPrices']?.map((x) => CompanyPriceModel.fromMap(x)))
          : null,
    );
  }
}
