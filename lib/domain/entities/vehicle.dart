import 'package:equatable/equatable.dart' show Equatable;
import 'package:equatable/equatable.dart';

import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/entities/vehicle_brand.dart';
import 'package:insurance_app/domain/entities/vehicle_country.dart';
import 'package:insurance_app/domain/entities/vehicle_insurance.dart';
import 'package:insurance_app/domain/entities/vehicle_model.dart';
import 'package:insurance_app/domain/entities/vehicle_type.dart';

import '../../app/constants.dart';

class VehicleEntity extends Equatable {
  final int id;
  final int makingYear;
  final String licensePlate;
  final bool isHidden;
  final String alias;
  final String ownerFirstName;
  final String ownerFatherName;
  final String ownerLastName;
  final VehicleInsuranceEntity? insurance;
  final VehicleBrandEntity brand;
  final VehicleModelEntity model;
  final VehicleCountryEntity country;
  final CityEntity city;
  final VehicleTypeEntity type;

  factory VehicleEntity.empty() => VehicleEntity(
        id: Constants.zero,
        makingYear: Constants.zero,
        licensePlate: Constants.empty,
        isHidden: false,
        alias: Constants.empty,
        ownerFirstName: Constants.empty,
        ownerFatherName: Constants.empty,
        ownerLastName: Constants.empty,
        insurance: VehicleInsuranceEntity.empty(),
        brand: const VehicleBrandEntity(
            id: Constants.zero, name: Constants.empty, icon: Constants.empty),
        model: const VehicleModelEntity(
            id: Constants.zero,
            name: Constants.empty,
            vehicleBrandId: Constants.zero),
        country: const VehicleCountryEntity(
            id: Constants.zero, name: Constants.empty, icon: Constants.empty),
        city: CityEntity.empty(),
        type:
            const VehicleTypeEntity(id: Constants.zero, name: Constants.empty),
      );

  const VehicleEntity({
    required this.id,
    required this.makingYear,
    required this.licensePlate,
    required this.isHidden,
    required this.alias,
    required this.ownerFirstName,
    required this.ownerFatherName,
    required this.ownerLastName,
    required this.insurance,
    required this.brand,
    required this.model,
    required this.country,
    required this.city,
    required this.type,
  });

  @override
  List<Object?> get props {
    return [
      id,
      makingYear,
      licensePlate,
      isHidden,
      alias,
      ownerFirstName,
      ownerFatherName,
      ownerLastName,
      insurance,
      brand,
      model,
      country,
      city,
      type,
    ];
  }
}
