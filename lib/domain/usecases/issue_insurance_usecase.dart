import 'package:dartz/dartz.dart';

import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../repositories/insurance_repository.dart';

class IssueInsuranceUsecase
    implements BaseUsecase<IssueInsuranceUsecaseInput, InsuranceEntity> {
  final InsuranceRepository _repository;

  IssueInsuranceUsecase(this._repository);
  @override
  Future<Either<Failure, InsuranceEntity>> execute(
      IssueInsuranceUsecaseInput input) async {
    return await _repository.issueInsurance(IssueInsuranceRequest(
      companyId: input.companyId,
      insuranceTypeId: input.insuranceTypeId,
      vehicleId: input.vehicleId,
      startDate: input.startDate,
      endDate: input.endDate,
    ));
  }
}

class IssueInsuranceUsecaseInput {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleId;
  final String startDate;
  final String endDate;
  const IssueInsuranceUsecaseInput({
    required this.companyId,
    required this.insuranceTypeId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
  });
}
