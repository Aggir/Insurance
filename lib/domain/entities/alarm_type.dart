import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';

class AlarmTypesEntity extends Equatable {
  final String name;
  final int id;

  const AlarmTypesEntity({
    required this.name,
    required this.id,
  });

  factory AlarmTypesEntity.empty() =>
      const AlarmTypesEntity(name: Constants.empty, id: Constants.zero);

  @override
  List<Object> get props => [name, id];
}
