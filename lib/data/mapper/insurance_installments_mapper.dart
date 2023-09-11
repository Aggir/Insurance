import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/insurance_installment_model.dart';
import 'package:insurance_app/domain/entities/insurance_installments.dart';

extension InsuranceInstallmentsModelExtension on InsuranceInstallmentModel? {
  InsuranceInstallmentsEntity toDomain() => this == null
      ? InsuranceInstallmentsEntity.empty()
      : InsuranceInstallmentsEntity(
          subServiceId: this?.subServiceId ?? Constants.zero,
          installmentsValue: this?.installmentsValue ?? Constants.dZero,
          installmentsCount: this?.installmentsCount ?? Constants.zero,
          valid: this?.valid ?? false);
}
