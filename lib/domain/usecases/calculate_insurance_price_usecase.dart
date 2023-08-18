import 'package:dartz/dartz.dart';

import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../repositories/insurance_repository.dart';

class CalculateInsurancePriceUsecase
    implements BaseUsecase<CalculateInsurancePriceUsecaseInput, String> {
  final InsuranceRepository _repository;

  CalculateInsurancePriceUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(
      CalculateInsurancePriceUsecaseInput input) async {
    return await _repository
        .calculateInsurancePrice(CalculateInsurancePriceRequest(
      companyId: input.companyId,
      insuranceTypeId: input.insuranceTypeId,
      vehicleId: input.insuranceTypeId,
    ));
  }
}

class CalculateInsurancePriceUsecaseInput {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleId;
  CalculateInsurancePriceUsecaseInput({
    required this.companyId,
    required this.insuranceTypeId,
    required this.vehicleId,
  });
}
