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
  final String insuranceType;
  final String carBrand;
  final String carBrandImgPath;
  final String insuranceCompany;
  final InsuranceStatus insuranceStatus;
  const Insurance({
    required this.id,
    required this.insuranceTypeId,
    required this.carBrandId,
    required this.insuranceCompanyId,
    required this.referenceNumber,
    required this.issuanceDate,
    required this.insuredName,
    required this.insuranceType,
    required this.carBrand,
    required this.carBrandImgPath,
    required this.insuranceCompany,
    required this.insuranceStatus,
  });

  Insurance copyWith({
    int? id,
    int? insuranceTypeId,
    int? carBrandId,
    int? insuranceCompanyId,
    String? referenceNumber,
    String? issuanceDate,
    String? insuredName,
    String? insuranceType,
    String? carBrand,
    String? carBrandImgPath,
    String? insuranceCompany,
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
      insuranceType: insuranceType ?? this.insuranceType,
      carBrand: carBrand ?? this.carBrand,
      carBrandImgPath: carBrandImgPath ?? this.carBrandImgPath,
      insuranceCompany: insuranceCompany ?? this.insuranceCompany,
      insuranceStatus: insuranceStatus ?? this.insuranceStatus,
    );
  }

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
      insuranceType,
      carBrand,
      carBrandImgPath,
      insuranceCompany,
      insuranceStatus,
    ];
  }
}
