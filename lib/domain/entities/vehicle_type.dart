import 'package:equatable/equatable.dart';

class VehicleTypeEntity extends Equatable {
  final int id;
  final String name;
  const VehicleTypeEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  @override
  String toString() => 'VehicleTypeEntity(id: $id, name: $name)';
}
