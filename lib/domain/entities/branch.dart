import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/constants.dart';

class BranchEntity extends Equatable {
  final int id;
  final String name;
  final double lat;
  final double lng;
  final int companyId;

  const BranchEntity({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.companyId,
  });

  factory BranchEntity.empty() => const BranchEntity(
        id: Constants.zero,
        name: Constants.empty,
        lat: Constants.dZero,
        lng: Constants.dZero,
        companyId: Constants.zero,
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      lat,
      lng,
      companyId,
    ];
  }

  @override
  String toString() {
    return 'BranchEntity(id: $id, name: $name, lat: $lat, lng: $lng, companyId: $companyId)';
  }
}
