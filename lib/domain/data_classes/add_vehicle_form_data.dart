import 'package:equatable/equatable.dart';

import 'package:insurance_app/domain/entities/vehicle_brand.dart';
import 'package:insurance_app/domain/entities/vehicle_country.dart';
import 'package:insurance_app/domain/entities/vehicle_model.dart';
import 'package:insurance_app/domain/entities/vehicle_ownership_type.dart';
import 'package:insurance_app/domain/entities/vehicle_type.dart';

class AddVehicleFormData extends Equatable {
  final List<VehicleTypeEntity>? vehicleTypes;
  final List<VehicleBrandEntity>? vehicleBrands;
  final List<VehicleModelEntity>? vehicleModels;
  final List<VehicleCountryEntity>? vehicleCountries;
  final List<VehicleOwnershipTypeEntity>? vehicleOwnershipTypes;
  const AddVehicleFormData({
    this.vehicleTypes,
    this.vehicleBrands,
    this.vehicleModels,
    this.vehicleCountries,
    this.vehicleOwnershipTypes,
  });

  @override
  List<Object?> get props => [
        vehicleTypes,
        vehicleBrands,
        vehicleModels,
        vehicleCountries,
        vehicleOwnershipTypes,
      ];

  @override
  String toString() {
    return 'AddVehicleFormData(vehicleTypes: $vehicleTypes, vehicleBrands: $vehicleBrands, vehicleModels: $vehicleModels, vehicleCountries: $vehicleCountries)';
  }

  AddVehicleFormData copyWith({
    List<VehicleTypeEntity>? vehicleTypes,
    List<VehicleBrandEntity>? vehicleBrands,
    List<VehicleModelEntity>? vehicleModels,
    List<VehicleCountryEntity>? vehicleCountries,
    List<VehicleOwnershipTypeEntity>? vehicleOwnershipTypes,
  }) {
    return AddVehicleFormData(
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
      vehicleBrands: vehicleBrands ?? this.vehicleBrands,
      vehicleModels: vehicleModels ?? this.vehicleModels,
      vehicleCountries: vehicleCountries ?? this.vehicleCountries,
      vehicleOwnershipTypes:
          vehicleOwnershipTypes ?? this.vehicleOwnershipTypes,
    );
  }
}
