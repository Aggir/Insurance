import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/notification.dart';
import 'package:insurance_app/domain/usecases/count_unseen_notifications_usecase.dart';
import 'package:insurance_app/domain/usecases/get_notifications_usecase.dart';
import 'package:insurance_app/domain/usecases/notification_read_usecase.dart';
import 'package:insurance_app/domain/usecases/notifications_seen_usecase.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  bool isDisposed = false;

  Timer? unseenNotificationsTimer;

  init() async {
    emit(state.copyWith(fetchNotificationsStatus: Status.loading));
    initGetNotifications();
    (await instance<GetNotificationsUsecase>().execute(null)).fold(
      (failure) {
        if (!isDisposed) {
          emit(state.copyWith(
              fetchNotificationsStatus: Status.failure,
              fetchNotificationsErrorMessage: failure.message));
        }
      },
      (notifications) {
        if (!isDisposed) {
          emit(state.copyWith(
            fetchNotificationsStatus: Status.success,
            notifications: notifications,
            seenNotifications: notifications
                .where((notification) => notification.isSeen)
                .toList(),
            unseenNotifications: notifications
                .where((notification) => !notification.isSeen)
                .toList(),
          ));
        }
      },
    );
  }

  toggleSeen() async {
    emit(state.copyWith(toggleSeenStatus: Status.loading));
    initNotificationsSeen();
    (await instance<NotificationsSeenUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
            toggleSeenStatus: Status.failure,
            toggleSeenErrorMessage: failure.message)),
        (_) => emit(state.copyWith(
              toggleSeenStatus: Status.success,
              countUnseen: 0,
            )));
  }

  startUnseenNotificationsTimer() {
    _countUnseen();
    unseenNotificationsTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      _countUnseen();
    });
  }

  stopUnseenNotificationsTimer() {
    unseenNotificationsTimer?.cancel();
  }

  _countUnseen() async {
    if (!isDisposed) {
      emit(state.copyWith(countUnseenStatus: Status.loading));
      initCountUnseenNotifications();
      (await instance<CountUnseenNotificationsUsecase>().execute(null)).fold(
          (failure) {
        if (!isDisposed) {
          emit(state.copyWith(
              countUnseenStatus: Status.failure,
              countUnseenErrorMessage: failure.message));
        }
      }, (count) {
        if (!isDisposed) {
          emit(state.copyWith(
              countUnseenStatus: Status.success, countUnseen: count));
        }
      });
    }
  }

  toggleRead(int id) async {
    int? index = state.notifications?.indexWhere((element) => element.id == id);

    NotificationEntity? tempNotification = state.notifications?[index ?? 0];
    List<NotificationEntity>? newNotifications = state.notifications;
    if (index != null &&
        state.notifications != null &&
        newNotifications != null &&
        tempNotification != null) {
      newNotifications.replaceRange(index, index + 1, [
        tempNotification.copyWith(isRead: true),
      ]);
    }

    emit(state.copyWith(
      toggleReadStatus: Status.loading,
      notifications: newNotifications,
      seenNotifications: newNotifications
          ?.where((notification) => notification.isSeen)
          .toList(),
      unseenNotifications: newNotifications
          ?.where((notification) => !notification.isSeen)
          .toList(),
    ));
    initNotificationsRead();
    (await instance<NotificationReadUsecase>().execute(id)).fold((failure) {
      NotificationEntity? tempNotification = state.notifications?[index ?? 0];
      List<NotificationEntity>? newNotifications = state.notifications;
      if (index != null &&
          state.notifications != null &&
          newNotifications != null &&
          tempNotification != null) {
        newNotifications.replaceRange(
            index, index + 1, [tempNotification.copyWith(isRead: false)]);
      }
      emit(state.copyWith(
        toggleReadStatus: Status.failure,
        toggleReadErrorMessage: failure.message,
        notifications: newNotifications,
        seenNotifications: newNotifications
            ?.where((notification) => notification.isSeen)
            .toList(),
        unseenNotifications: newNotifications
            ?.where((notification) => !notification.isSeen)
            .toList(),
      ));
    }, (_) {
      emit(state.copyWith(
        toggleReadStatus: Status.success,
      ));
    });
  }

  @override
  Future<void> close() {
    stopUnseenNotificationsTimer();
    isDisposed = true;
    return super.close();
  }
}
