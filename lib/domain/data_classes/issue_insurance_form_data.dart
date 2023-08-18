import 'package:equatable/equatable.dart';

import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/entities/vehicle.dart';

class IssueInsuranceFormData extends Equatable {
  final List<CompanyEntity> companies;
  final List<InsuranceTypeEntity> insuranceTypes;
  final List<VehicleEntity> vehicles;

  const IssueInsuranceFormData({
    required this.companies,
    required this.insuranceTypes,
    required this.vehicles,
  });

  @override
  List<Object?> get props => [companies, insuranceTypes, vehicles];
}
