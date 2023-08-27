import 'package:equatable/equatable.dart';

class RemindMeInEntity extends Equatable {
  final int id;
  final int days;
  final String name;

  const RemindMeInEntity({
    required this.id,
    required this.days,
    required this.name,
  });

  @override
  List<Object> get props => [id, days, name];
}
