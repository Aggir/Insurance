import 'package:insurance_app/data/models/company_model.dart';

class CompanyPriceModel {
  final CompanyModel? company;
  final double? price;
  CompanyPriceModel({
    this.company,
    this.price,
  });

  factory CompanyPriceModel.fromMap(Map<String, dynamic> map) {
    return CompanyPriceModel(
      company: CompanyModel.fromMap(map),
      price: map['price']?.toDouble(),
    );
  }
}
