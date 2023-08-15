import 'package:equatable/equatable.dart';

class VehicleOwnershipTypeEntity extends Equatable {
  final int id;
  final String name;
  const VehicleOwnershipTypeEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
