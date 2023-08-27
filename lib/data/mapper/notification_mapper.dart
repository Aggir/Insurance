import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/notification_type.dart';
import 'package:insurance_app/data/models/notification_model.dart';
import 'package:insurance_app/domain/entities/notification.dart';

extension NotificationModelExtension on NotificationModel? {
  NotificationEntity toDomain() => this == null
      ? NotificationEntity.empty()
      : NotificationEntity(
          id: this?.id ?? Constants.zero,
          createdAt: this?.createdAt ?? DateTime.now(),
          isRead: this?.isRead ?? false,
          isSeen: this?.isSeen ?? false,
          icon: this?.icon ?? Constants.empty,
          type: this?.type?.toNotificationType() ?? NotificationType.success,
          title: this?.title ?? Constants.empty,
          url: this?.url ?? Constants.empty,
        );
}
