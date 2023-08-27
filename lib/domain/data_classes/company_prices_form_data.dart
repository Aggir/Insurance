import 'package:equatable/equatable.dart';

import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/entities/vehicle_brand.dart';

class CompanyPricesFormData extends Equatable {
  final List<InsuranceTypeEntity> insuranceTypes;
  final List<VehicleBrandEntity> vehicleBrands;

  const CompanyPricesFormData({
    required this.insuranceTypes,
    required this.vehicleBrands,
  });

  @override
  List<Object> get props => [insuranceTypes, vehicleBrands];
}
