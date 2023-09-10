import 'package:equatable/equatable.dart';

import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/entities/vehicle_type.dart';

class CompanyPricesFormData extends Equatable {
  final List<InsuranceTypeEntity> insuranceTypes;
  final List<VehicleTypeEntity> vehicleTypes;

  const CompanyPricesFormData({
    required this.insuranceTypes,
    required this.vehicleTypes,
  });

  @override
  List<Object> get props => [insuranceTypes, vehicleTypes];
}
