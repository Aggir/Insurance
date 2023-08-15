import 'package:insurance_app/app/constants.dart';
import '../../domain/entities/vehicle_model.dart';
import '../models/vehicle_model_model.dart';

extension VehicleModelModelExtension on VehicleModelModel? {
  VehicleModelEntity toDomain() => this == null
      ? const VehicleModelEntity(
          id: Constants.zero,
          name: Constants.empty,
          vehicleBrandId: Constants.zero,
        )
      : VehicleModelEntity(
          id: this!.id,
          name: this!.name,
          vehicleBrandId: this!.vehicleBrandId,
        );
}
