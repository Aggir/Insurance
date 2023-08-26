import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

enum NotificationType {
  success,
  warning,
  error,
}

extension NotificationTypeExtension on NotificationType {
  bool get isSuccess => this == NotificationType.success;
  bool get isWarning => this == NotificationType.warning;
  bool get isError => this == NotificationType.error;

  Color getIconColor() {
    switch (this) {
      case NotificationType.success:
        return AppColors.secondary;
      case NotificationType.warning:
        return AppColors.primary;
      case NotificationType.error:
        return AppColors.danger;
    }
  }

  Color getBackgroundColor() {
    switch (this) {
      case NotificationType.success:
        return AppColors.secondaryLight;
      case NotificationType.warning:
        return AppColors.primaryLight;
      case NotificationType.error:
        return AppColors.primaryLight2;
    }
  }
}

extension StringToNotificationTypeExtension on String {
  NotificationType toNotificationType() {
    switch (toLowerCase()) {
      case 'error':
        return NotificationType.error;
      case 'warning':
        return NotificationType.warning;
      case 'success':
      default:
        return NotificationType.success;
    }
  }
}
