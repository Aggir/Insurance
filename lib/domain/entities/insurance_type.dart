import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/constants.dart';

class InsuranceTypeEntity extends Equatable {
  final int id;
  final String name;
  const InsuranceTypeEntity({
    required this.id,
    required this.name,
  });

  factory InsuranceTypeEntity.empty() =>
      const InsuranceTypeEntity(id: Constants.zero, name: Constants.empty);

  @override
  List<Object> get props => [id, name];
}
