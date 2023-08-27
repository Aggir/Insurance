import 'package:equatable/equatable.dart';

import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/domain/entities/meta.dart';

class CompaniesPage extends Equatable {
  final List<CompanyEntity> companies;
  final MetaEntity meta;

  const CompaniesPage({
    required this.companies,
    required this.meta,
  });

  @override
  List<Object> get props => [companies, meta];
}
