import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/vehicle_brand_model.dart';
import 'package:insurance_app/domain/entities/vehicle_brand.dart';

extension VehicleBrandModelExtension on VehicleBrandModel? {
  VehicleBrandEntity toDomain() => this == null
      ? const VehicleBrandEntity(
          id: Constants.zero,
          name: Constants.empty,
          icon: Constants.empty,
        )
      : VehicleBrandEntity(id: this!.id, name: this!.name, icon: this!.icon);
}
