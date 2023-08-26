part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final Status fetchNotificationsStatus;
  final String? fetchNotificationsErrorMessage;
  final List<NotificationEntity>? notifications;
  final List<NotificationEntity>? seenNotifications;
  final List<NotificationEntity>? unseenNotifications;
  final Status toggleSeenStatus;
  final String? toggleSeenErrorMessage;
  final Status toggleReadStatus;
  final String? toggleReadErrorMessage;
  final int countUnseen;
  final Status countUnseenStatus;
  final String? countUnseenErrorMessage;

  const NotificationsState({
    this.fetchNotificationsStatus = Status.initial,
    this.fetchNotificationsErrorMessage,
    this.notifications,
    this.seenNotifications,
    this.unseenNotifications,
    this.toggleSeenStatus = Status.initial,
    this.toggleSeenErrorMessage,
    this.toggleReadStatus = Status.initial,
    this.toggleReadErrorMessage,
    this.countUnseen = 0,
    this.countUnseenStatus = Status.initial,
    this.countUnseenErrorMessage,
  });

  @override
  List<Object?> get props => [
        fetchNotificationsStatus,
        fetchNotificationsErrorMessage,
        notifications,
        seenNotifications,
        unseenNotifications,
        toggleSeenStatus,
        toggleSeenErrorMessage,
        toggleReadStatus,
        toggleReadErrorMessage,
        countUnseen,
        countUnseenStatus,
        countUnseenErrorMessage,
      ];

  NotificationsState copyWith({
    Status? fetchNotificationsStatus,
    String? fetchNotificationsErrorMessage,
    List<NotificationEntity>? notifications,
    List<NotificationEntity>? seenNotifications,
    List<NotificationEntity>? unseenNotifications,
    Status? toggleSeenStatus,
    String? toggleSeenErrorMessage,
    Status? toggleReadStatus,
    String? toggleReadErrorMessage,
    int? countUnseen,
    Status? countUnseenStatus,
    String? countUnseenErrorMessage,
  }) {
    return NotificationsState(
      fetchNotificationsStatus:
          fetchNotificationsStatus ?? this.fetchNotificationsStatus,
      fetchNotificationsErrorMessage:
          fetchNotificationsErrorMessage ?? this.fetchNotificationsErrorMessage,
      notifications: notifications ?? this.notifications,
      seenNotifications: seenNotifications ?? this.seenNotifications,
      unseenNotifications: unseenNotifications ?? this.unseenNotifications,
      toggleSeenStatus: toggleSeenStatus ?? this.toggleSeenStatus,
      toggleSeenErrorMessage:
          toggleSeenErrorMessage ?? this.toggleSeenErrorMessage,
      toggleReadStatus: toggleReadStatus ?? this.toggleReadStatus,
      toggleReadErrorMessage:
          toggleReadErrorMessage ?? this.toggleReadErrorMessage,
      countUnseen: countUnseen ?? this.countUnseen,
      countUnseenStatus: countUnseenStatus ?? this.countUnseenStatus,
      countUnseenErrorMessage:
          countUnseenErrorMessage ?? this.countUnseenErrorMessage,
    );
  }
}
