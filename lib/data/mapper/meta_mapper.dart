import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/meta_model.dart';
import 'package:insurance_app/domain/entities/meta.dart';

extension MetaModelExtension on MetaModel? {
  MetaEntity toDomain() => MetaEntity(
      currentPage: this?.currentPage ?? Constants.zero,
      from: this?.from ?? Constants.zero,
      lastPage: this?.lastPage ?? Constants.zero);
}

extension MetaEntityExtension on MetaEntity? {
  MetaModel toData() => MetaModel(
      currentPage: this?.currentPage ?? Constants.zero,
      from: this?.from ?? Constants.zero,
      lastPage: this?.lastPage ?? Constants.zero);
}
