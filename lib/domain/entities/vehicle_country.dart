import 'package:equatable/equatable.dart';

class VehicleCountryEntity extends Equatable {
  final int id;
  final String name;
  final String icon;
  const VehicleCountryEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  @override
  List<Object> get props => [id, name, icon];

  @override
  String toString() =>
      'VehicleCountryEntity(id: $id, name: $name, icon: $icon)';
}
