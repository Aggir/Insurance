import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/enums/insurance_types_enum.dart';

class Insurance extends Equatable {
  final int id;
  final int insuranceTypeId;
  final int carBrandId;
  final int insuranceCompanyId;
  final String referenceNumber;
  final String issuanceDate;
  final String insuredName;
  final InsuranceStatus insuranceStatus;

  const Insurance({
    required this.id,
    required this.insuranceTypeId,
    required this.carBrandId,
    required this.insuranceCompanyId,
    required this.referenceNumber,
    required this.issuanceDate,
    required this.insuredName,
    required this.insuranceStatus,
  });

  @override
  List<Object> get props {
    return [
      id,
      insuranceTypeId,
      carBrandId,
      insuranceCompanyId,
      referenceNumber,
      issuanceDate,
      insuredName,
      insuranceStatus,
    ];
  }

  Insurance copyWith({
    int? id,
    int? insuranceTypeId,
    int? carBrandId,
    int? insuranceCompanyId,
    String? referenceNumber,
    String? issuanceDate,
    String? insuredName,
    InsuranceStatus? insuranceStatus,
  }) {
    return Insurance(
      id: id ?? this.id,
      insuranceTypeId: insuranceTypeId ?? this.insuranceTypeId,
      carBrandId: carBrandId ?? this.carBrandId,
      insuranceCompanyId: insuranceCompanyId ?? this.insuranceCompanyId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      issuanceDate: issuanceDate ?? this.issuanceDate,
      insuredName: insuredName ?? this.insuredName,
      insuranceStatus: insuranceStatus ?? this.insuranceStatus,
    );
  }
}
