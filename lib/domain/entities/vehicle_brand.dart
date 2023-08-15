import 'package:equatable/equatable.dart';

class VehicleBrandEntity extends Equatable {
  final int id;
  final String name;
  final String icon;
  const VehicleBrandEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  @override
  List<Object> get props => [id, name, icon];

  @override
  String toString() => 'VehicleBrandEntity(id: $id, name: $name, icon: $icon)';
}
