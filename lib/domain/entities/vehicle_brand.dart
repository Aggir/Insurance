import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';

class VehicleBrandEntity extends Equatable {
  final int id;
  final String name;
  final String icon;
  const VehicleBrandEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory VehicleBrandEntity.empty() => const VehicleBrandEntity(
      id: Constants.zero, name: Constants.empty, icon: Constants.empty);

  @override
  List<Object> get props => [id, name, icon];

  @override
  String toString() => 'VehicleBrandEntity(id: $id, name: $name, icon: $icon)';
}
