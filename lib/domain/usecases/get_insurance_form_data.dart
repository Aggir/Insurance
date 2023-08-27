import 'package:dartz/dartz.dart';
import 'package:insurance_app/domain/data_classes/issue_insurance_form_data.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../../app/failure.dart';

class GetInsuranceFormData
    implements BaseUsecase<void, IssueInsuranceFormData> {
  final InsuranceRepository _repository;
  const GetInsuranceFormData(this._repository);
  @override
  Future<Either<Failure, IssueInsuranceFormData>> execute(void input) async {
    return await _repository.getInsuranceFormData();
  }
}
