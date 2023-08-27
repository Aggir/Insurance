import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/domain/entities/vehicle_brand.dart';

class InsuranceVehicleEntity extends Equatable {
  final int id;
  final bool isHidden;
  final String alias;
  final String ownerFirstName;
  final String ownerFatherName;
  final String ownerLastName;
  final String photo;
  final VehicleBrandEntity brand;
  const InsuranceVehicleEntity({
    required this.id,
    required this.isHidden,
    required this.alias,
    required this.ownerFirstName,
    required this.ownerFatherName,
    required this.ownerLastName,
    required this.photo,
    required this.brand,
  });

  factory InsuranceVehicleEntity.empty() => InsuranceVehicleEntity(
        id: Constants.zero,
        isHidden: false,
        alias: Constants.empty,
        ownerFirstName: Constants.empty,
        ownerFatherName: Constants.empty,
        ownerLastName: Constants.empty,
        photo: Constants.empty,
        brand: VehicleBrandEntity.empty(),
      );

  @override
  List<Object> get props {
    return [
      id,
      isHidden,
      alias,
      ownerFirstName,
      ownerFatherName,
      ownerLastName,
      photo,
    ];
  }
}
