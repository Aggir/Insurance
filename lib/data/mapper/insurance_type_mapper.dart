import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/insurance_type_model.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';

extension InsuranceTypeModelExtension on InsuranceTypeModel? {
  InsuranceTypeEntity toDomain() => this == null
      ? InsuranceTypeEntity.empty()
      : InsuranceTypeEntity(
          id: this?.id ?? Constants.zero,
          name: this?.name ?? Constants.empty,
        );
}
