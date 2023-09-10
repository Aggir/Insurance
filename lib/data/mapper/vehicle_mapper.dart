import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/mapper/city_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_brand_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_country_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_insurance_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_model_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_type_mapper.dart';
import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/entities/vehicle_brand.dart';
import 'package:insurance_app/domain/entities/vehicle_country.dart';
import 'package:insurance_app/domain/entities/vehicle_model.dart';
import 'package:insurance_app/domain/entities/vehicle_type.dart';

import '../../domain/entities/vehicle.dart';
import '../models/vehicle_model.dart';

extension VehicleModelExtension on VehicleModel? {
  VehicleEntity toDomain() => this == null
      ? VehicleEntity.empty()
      : VehicleEntity(
          id: this?.id ?? Constants.zero,
          makingYear: this?.makingYear ?? Constants.zero,
          licensePlate: this?.licensePlate ?? Constants.empty,
          isHidden: this?.isHidden ?? false,
          alias: this?.alias ?? Constants.empty,
          ownerFirstName: this?.ownerFirstName ?? Constants.empty,
          ownerFatherName: this?.ownerFatherName ?? Constants.empty,
          ownerLastName: this?.ownerLastName ?? Constants.empty,
          insurance: this?.insurance?.toDomain(),
          brand: this?.brand?.toDomain() ??
              const VehicleBrandEntity(
                  id: Constants.zero,
                  name: Constants.empty,
                  icon: Constants.empty),
          model: this?.model?.toDomain() ??
              const VehicleModelEntity(
                  vehicleBrandId: Constants.zero,
                  id: Constants.zero,
                  name: Constants.empty),
          country: this?.country?.toDomain() ??
              const VehicleCountryEntity(
                  id: Constants.zero,
                  name: Constants.empty,
                  icon: Constants.empty),
          city: this?.city?.toDomain() ?? CityEntity.empty(),
          type: this?.type?.toDomain() ??
              const VehicleTypeEntity(
                id: Constants.zero,
                name: Constants.empty,
              ),
        );
}
