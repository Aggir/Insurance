import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/mapper/vehicle_brand_mapper.dart';
import 'package:insurance_app/data/models/insurance_vehicle_model.dart';
import 'package:insurance_app/domain/entities/insurance_vehicle.dart';
import 'package:insurance_app/domain/entities/vehicle_brand.dart';

extension InsuranceVehicleModelExtension on InsuranceVehicleModel? {
  InsuranceVehicleEntity toDomain() => this == null
      ? InsuranceVehicleEntity.empty()
      : InsuranceVehicleEntity(
          id: this?.id ?? Constants.zero,
          isHidden: this?.isHidden ?? false,
          alias: this?.alias ?? Constants.empty,
          ownerFirstName: this?.ownerFirstName ?? Constants.empty,
          ownerFatherName: this?.ownerFatherName ?? Constants.empty,
          ownerLastName: this?.ownerLastName ?? Constants.empty,
          photo: this?.photo ?? Constants.empty,
          brand: this?.brand.toDomain() ?? VehicleBrandEntity.empty(),
        );
}
