import 'package:equatable/equatable.dart';
import 'package:insurance_app/domain/entities/insurance.dart';

import 'package:insurance_app/domain/entities/meta.dart';

class InsurancesPage extends Equatable {
  final List<InsuranceEntity>? insurances;
  final MetaEntity? meta;

  const InsurancesPage({
    this.insurances,
    this.meta,
  });

  @override
  List<Object?> get props => [insurances, meta];
}
