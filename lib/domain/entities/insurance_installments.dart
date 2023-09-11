import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/constants.dart';

class InsuranceInstallmentsEntity extends Equatable {
  final int subServiceId;
  final double installmentsValue;
  final int installmentsCount;
  final bool valid;
  const InsuranceInstallmentsEntity({
    required this.subServiceId,
    required this.installmentsValue,
    required this.installmentsCount,
    required this.valid,
  });

  factory InsuranceInstallmentsEntity.empty() =>
      const InsuranceInstallmentsEntity(
        subServiceId: Constants.zero,
        installmentsValue: Constants.dZero,
        installmentsCount: Constants.zero,
        valid: false,
      );

  @override
  List<Object> get props => [
        subServiceId,
        installmentsValue,
        installmentsCount,
        valid,
      ];
}
