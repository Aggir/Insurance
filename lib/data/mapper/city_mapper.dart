import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/city_model.dart';
import 'package:insurance_app/domain/entities/city.dart';

extension CityModelExtension on CityModel? {
  CityEntity toDomain() => this == null
      ? const CityEntity(id: Constants.zero, name: Constants.empty)
      : CityEntity(id: this!.id, name: this!.name);
}
