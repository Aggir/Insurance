import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/alarm_type_model.dart';
import 'package:insurance_app/domain/entities/alarm_type.dart';

extension AlarmTypeModelExtension on AlarmTypeModel? {
  AlarmTypesEntity toDomain() => this == null
      ? AlarmTypesEntity.empty()
      : AlarmTypesEntity(
          name: this?.name ?? Constants.empty, id: this?.id ?? Constants.zero);
}
