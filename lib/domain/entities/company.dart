import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/constants.dart';

class CompanyEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String photo;
  final int priority;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.priority,
  });

  factory CompanyEntity.empty() => const CompanyEntity(
        id: Constants.zero,
        name: Constants.empty,
        description: Constants.empty,
        photo: Constants.empty,
        priority: Constants.zero,
      );

  @override
  List<Object> get props => [
        id,
        name,
        priority,
        description,
        photo,
      ];
}
