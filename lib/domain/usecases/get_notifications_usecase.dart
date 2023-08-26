import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/entities/notification.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetNotificationsUsecase
    implements BaseUsecase<void, List<NotificationEntity>> {
  final Repository _repository;

  GetNotificationsUsecase(this._repository);
  @override
  Future<Either<Failure, List<NotificationEntity>>> execute(void input) async {
    return await _repository.getNotifications();
  }
}
