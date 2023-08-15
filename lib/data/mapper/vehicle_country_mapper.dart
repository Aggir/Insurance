import 'package:insurance_app/app/constants.dart';

import '../../domain/entities/vehicle_country.dart';
import '../models/vehicle_country_model.dart';

extension VehicleCountryModelExtension on VehicleCountryModel? {
  VehicleCountryEntity toDomain() => this == null
      ? const VehicleCountryEntity(
          id: Constants.zero,
          name: Constants.empty,
          icon: Constants.empty,
        )
      : VehicleCountryEntity(id: this!.id, name: this!.name, icon: this!.icon);
}
