import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/notification_type.dart';

class NotificationEntity extends Equatable {
  final int id;
  final DateTime createdAt;
  final bool isRead;
  final bool isSeen;
  final String icon;
  final NotificationType type;
  final String title;
  final String url;

  const NotificationEntity({
    required this.id,
    required this.createdAt,
    required this.isRead,
    required this.isSeen,
    required this.icon,
    required this.type,
    required this.title,
    required this.url,
  });

  factory NotificationEntity.empty() => NotificationEntity(
        id: Constants.zero,
        createdAt: DateTime.now(),
        isRead: false,
        isSeen: false,
        icon: Constants.empty,
        type: NotificationType.success,
        title: Constants.empty,
        url: Constants.empty,
      );

  @override
  List<Object> get props {
    return [
      id,
      createdAt,
      isRead,
      isSeen,
      icon,
      type,
      title,
      url,
    ];
  }

  NotificationEntity copyWith({
    int? id,
    DateTime? createdAt,
    bool? isRead,
    bool? isSeen,
    String? icon,
    NotificationType? type,
    String? title,
    String? url,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      isSeen: isSeen ?? this.isSeen,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }
}
