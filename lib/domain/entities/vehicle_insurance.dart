import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/insurance_status.dart';

class VehicleInsuranceEntity extends Equatable {
  final int id;
  final int userId;
  final int companyId;
  final int vehicleId;
  final int insuranceTypeId;
  final bool isPaid;
  final String file;
  final String cost;
  final String startDate;
  final String endDate;
  final InsuranceStatus status;

  const VehicleInsuranceEntity({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.vehicleId,
    required this.insuranceTypeId,
    required this.isPaid,
    required this.file,
    required this.cost,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory VehicleInsuranceEntity.empty() => const VehicleInsuranceEntity(
        id: Constants.zero,
        userId: Constants.zero,
        companyId: Constants.zero,
        vehicleId: Constants.zero,
        insuranceTypeId: Constants.zero,
        isPaid: false,
        file: Constants.empty,
        cost: Constants.empty,
        startDate: Constants.empty,
        endDate: Constants.empty,
        status: InsuranceStatus.processing,
      );

  @override
  List<Object> get props {
    return [
      id,
      userId,
      companyId,
      vehicleId,
      insuranceTypeId,
      isPaid,
      file,
      cost,
      startDate,
      endDate,
      status,
    ];
  }
}
