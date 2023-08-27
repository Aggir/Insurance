import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';

import 'package:insurance_app/domain/entities/company.dart';

class CompanyPriceEntity extends Equatable {
  final CompanyEntity company;
  final double price;

  const CompanyPriceEntity({
    required this.company,
    required this.price,
  });

  factory CompanyPriceEntity.empty() => CompanyPriceEntity(
        company: CompanyEntity.empty(),
        price: Constants.dZero,
      );

  @override
  List<Object> get props => [company, price];
}
