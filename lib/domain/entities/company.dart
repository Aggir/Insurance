import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/constants.dart';

class CompanyEntity extends Equatable {
  final int id;
  final String name;
  final int priority;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.priority,
  });

  factory CompanyEntity.empty() => const CompanyEntity(
        id: Constants.zero,
        name: Constants.empty,
        priority: Constants.zero,
      );

  @override
  List<Object> get props => [id, name, priority];

  @override
  String toString() =>
      'CompanyEntity(id: $id, name: $name, priority: $priority)';
}
