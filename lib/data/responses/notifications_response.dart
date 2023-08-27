import 'package:insurance_app/data/models/notification_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class NotificationsResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<NotificationModel>? notifications;

  NotificationsResponse({
    this.code,
    this.message,
    this.notifications,
  });

  factory NotificationsResponse.fromMap(List<dynamic> map) {
    return NotificationsResponse(
      notifications: List<NotificationModel>.from(
          map.map((x) => NotificationModel.fromMap(x))),
    );
  }

  @override
  String toString() =>
      'NotificationsResponse(code: $code, message: $message, notifications: ${notifications?.length})';
}
