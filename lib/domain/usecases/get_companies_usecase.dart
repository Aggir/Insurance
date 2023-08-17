import 'package:dartz/dartz.dart';
import 'package:insurance_app/domain/data_classes/companies_page.dart';

import '../../app/failure.dart';
import '../repositories/repository.dart';
import 'base_usecase.dart';

class GetCompaniesUsecase implements BaseUsecase<int?, CompaniesPage> {
  final Repository _repository;
  const GetCompaniesUsecase(this._repository);
  @override
  Future<Either<Failure, CompaniesPage>> execute(int? page) async {
    return await _repository.getCompanies(page);
  }
}
