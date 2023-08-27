import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class NotificationReadUsecase implements BaseUsecase<int, void> {
  final Repository _repository;

  NotificationReadUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(int input) async {
    return await _repository.toggleNotificationIsRead(input);
  }
}
