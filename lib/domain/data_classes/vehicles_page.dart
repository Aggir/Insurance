import 'package:equatable/equatable.dart';

import 'package:insurance_app/domain/entities/meta.dart';
import 'package:insurance_app/domain/entities/vehicle.dart';

class VehiclesPage extends Equatable {
  final List<VehicleEntity>? vehicles;
  final MetaEntity? meta;

  const VehiclesPage({
    this.vehicles,
    this.meta,
  });

  @override
  List<Object?> get props => [vehicles, meta];
}
