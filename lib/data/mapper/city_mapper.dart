import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/city_model.dart';
import 'package:insurance_app/domain/entities/city.dart';

extension CityModelExtension on CityModel? {
  CityEntity toDomain() => this == null
      ? CityEntity.empty()
      : CityEntity(
          id: this?.id ?? Constants.zero,
          name: this?.name ?? Constants.empty,
          lat: this!.lat != null ? double.parse(this!.lat!) : Constants.dZero,
          lng: this!.lng != null ? double.parse(this!.lng!) : Constants.dZero,
        );
}
