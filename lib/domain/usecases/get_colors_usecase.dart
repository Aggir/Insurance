import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../entities/color.dart';

class GetColorsUsecase implements BaseUsecase<void, List<ColorEntity>> {
  final Repository _repository;
  const GetColorsUsecase(this._repository);
  @override
  Future<Either<Failure, List<ColorEntity>>> execute(void input) async {
    return await _repository.getColors();
  }
}
