import 'package:insurance_app/app/constants.dart';
import '../../domain/entities/vehicle_type.dart';
import '../models/vehicle_type_model.dart';

extension VehicleTypeModelExtension on VehicleTypeModel? {
  VehicleTypeEntity toDomain() => this == null
      ? const VehicleTypeEntity(
          id: Constants.zero,
          name: Constants.empty,
        )
      : VehicleTypeEntity(
          id: this!.id,
          name: this!.name,
        );
}
