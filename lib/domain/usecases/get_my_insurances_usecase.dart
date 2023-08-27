import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/data_classes/insurances_page.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetMyInsurancesUsecase implements BaseUsecase<int?, InsurancesPage> {
  final InsuranceRepository _repository;

  GetMyInsurancesUsecase(this._repository);

  @override
  Future<Either<Failure, InsurancesPage>> execute(int? page) async {
    return await _repository.getMyInsurances(page: page);
  }
}
