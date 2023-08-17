import 'package:equatable/equatable.dart';

import '../../app/constants.dart';

class CityEntity extends Equatable {
  final int id;
  final String name;
  final double lat;
  final double lng;

  const CityEntity({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory CityEntity.empty() => const CityEntity(
      id: Constants.zero,
      name: Constants.empty,
      lat: Constants.dZero,
      lng: Constants.dZero);

  @override
  List<Object?> get props => [
        id,
        name,
        lat,
        lng,
      ];
}
