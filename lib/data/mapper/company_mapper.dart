import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/company_model.dart';
import 'package:insurance_app/domain/entities/company.dart';

extension CompanyModelExtension on CompanyModel? {
  CompanyEntity toDomain() => this == null
      ? CompanyEntity.empty()
      : CompanyEntity(
          id: this?.id ?? Constants.zero,
          name: this?.name ?? Constants.empty,
          priority: this?.priority ?? Constants.zero,
          description: this?.description ?? Constants.empty,
          photo: this?.photo ?? Constants.empty,
        );
}
