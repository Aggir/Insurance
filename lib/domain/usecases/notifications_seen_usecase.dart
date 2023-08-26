import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class NotificationsSeenUsecase implements BaseUsecase<void, void> {
  final Repository _repository;

  NotificationsSeenUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(void input) async {
    return await _repository.toggleNotificationsIsSeen();
  }
}
