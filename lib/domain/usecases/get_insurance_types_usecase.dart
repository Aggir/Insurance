import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetInsuranceTypesUsecase
    implements BaseUsecase<void, List<InsuranceTypeEntity>> {
  final InsuranceRepository _repository;

  GetInsuranceTypesUsecase(this._repository);
  @override
  Future<Either<Failure, List<InsuranceTypeEntity>>> execute(void input) async {
    return await _repository.getInsuranceTypes();
  }
}
