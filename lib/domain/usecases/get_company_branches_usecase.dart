import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/entities/branch.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../repositories/repository.dart';

class GetCompanyBranchesUsecase
    implements BaseUsecase<int, List<BranchEntity>> {
  final Repository _repository;
  GetCompanyBranchesUsecase(this._repository);

  @override
  Future<Either<Failure, List<BranchEntity>>> execute(int companyId) async {
    return await _repository.getCompanyBranches(companyId);
  }
}
