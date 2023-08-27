import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';

import 'package:insurance_app/app/enums/insurance_status.dart';
import 'package:insurance_app/app/enums/insurance_types_enum.dart';
import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/entities/insurance_vehicle.dart';

class InsuranceEntity extends Equatable {
  final int id;
  final String startDate;
  final String endDate;
  final String cost;
  final String file;
  final bool isPaid;
  final InsuranceStatus status;
  final InsuranceVehicleEntity vehicle;
  final InsuranceTypeEntity insuranceType;
  final CompanyEntity company;
  final int referenceNumber;
  final InsuranceTypeStatus insuranceTypeStatus;
  const InsuranceEntity({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.cost,
    required this.file,
    required this.isPaid,
    required this.status,
    required this.vehicle,
    required this.insuranceType,
    required this.company,
    required this.referenceNumber,
    required this.insuranceTypeStatus,
  });

  @override
  List<Object> get props {
    return [
      id,
      startDate,
      endDate,
      cost,
      file,
      isPaid,
      status,
      vehicle,
      insuranceType,
      company,
      referenceNumber,
      insuranceTypeStatus,
    ];
  }

  factory InsuranceEntity.empty() => InsuranceEntity(
        id: Constants.zero,
        startDate: Constants.empty,
        endDate: Constants.empty,
        cost: Constants.empty,
        file: Constants.empty,
        isPaid: false,
        status: InsuranceStatus.processing,
        vehicle: InsuranceVehicleEntity.empty(),
        insuranceType: InsuranceTypeEntity.empty(),
        company: CompanyEntity.empty(),
        referenceNumber: Constants.zero,
        insuranceTypeStatus: InsuranceTypeStatus.underProcessing,
      );

  InsuranceEntity copyWith({
    int? id,
    String? startDate,
    String? endDate,
    String? cost,
    String? file,
    bool? isPaid,
    InsuranceStatus? status,
    InsuranceVehicleEntity? vehicle,
    InsuranceTypeEntity? insuranceType,
    CompanyEntity? company,
    int? referenceNumber,
    InsuranceTypeStatus? insuranceTypeStatus,
  }) {
    return InsuranceEntity(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cost: cost ?? this.cost,
      file: file ?? this.file,
      isPaid: isPaid ?? this.isPaid,
      status: status ?? this.status,
      vehicle: vehicle ?? this.vehicle,
      insuranceType: insuranceType ?? this.insuranceType,
      company: company ?? this.company,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      insuranceTypeStatus: insuranceTypeStatus ?? this.insuranceTypeStatus,
    );
  }
}
