import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class CountUnseenNotificationsUsecase implements BaseUsecase<void, int> {
  final Repository _repository;

  CountUnseenNotificationsUsecase(this._repository);
  @override
  Future<Either<Failure, int>> execute(void input) async {
    return await _repository.countUnseenNotifications();
  }
}
