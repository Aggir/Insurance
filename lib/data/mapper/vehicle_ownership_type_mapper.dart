import 'package:insurance_app/app/constants.dart';
import '../../domain/entities/vehicle_ownership_type.dart';
import '../models/vehicle_ownership_type_model.dart';

extension VehicleOwnershipTypeModelExtension on VehicleOwnershipTypeModel? {
  VehicleOwnershipTypeEntity toDomain() => this == null
      ? const VehicleOwnershipTypeEntity(
          id: Constants.zero,
          name: Constants.empty,
        )
      : VehicleOwnershipTypeEntity(
          id: this!.id,
          name: this!.name,
        );
}
