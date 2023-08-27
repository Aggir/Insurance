import 'package:equatable/equatable.dart';

class VehicleModelEntity extends Equatable {
  final int id;
  final String name;
  final int vehicleBrandId;
  const VehicleModelEntity({
    required this.id,
    required this.name,
    required this.vehicleBrandId,
  });

  @override
  List<Object> get props => [id, name, vehicleBrandId];

  @override
  String toString() =>
      'VehicleModelEntity(id: $id, name: $name, vehicleBrandId: $vehicleBrandId)';
}
