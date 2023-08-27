import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/mapper/company_mapper.dart';
import 'package:insurance_app/data/models/company_price_model.dart';
import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/domain/entities/company_price.dart';

extension CompanyPriceModelExtension on CompanyPriceModel? {
  CompanyPriceEntity toDomain() => this == null
      ? CompanyPriceEntity.empty()
      : CompanyPriceEntity(
          company: this?.company.toDomain() ?? CompanyEntity.empty(),
          price: this?.price ?? Constants.dZero);
}
