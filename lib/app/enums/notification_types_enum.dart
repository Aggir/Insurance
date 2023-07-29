import 'dart:ui';

import 'package:insurance_app/app/assets_manager.dart';

import '../../presentation/theme/app_colors.dart';

enum NotificationTypes {
  accepted,
  reminderAboutExpirationDate,
  expiryReminder,
  paymentCompleted,
}

extension NotificationTypesExtension on NotificationTypes {
  bool get isAccepted => this == NotificationTypes.accepted;
  bool get isReminderAboutExpirationDate =>
      this == NotificationTypes.reminderAboutExpirationDate;
  bool get isExpiryReminder => this == NotificationTypes.expiryReminder;
  bool get isPaymentCompleted => this == NotificationTypes.paymentCompleted;

  bool get isActionNotification =>
      this == NotificationTypes.expiryReminder ||
      this == NotificationTypes.reminderAboutExpirationDate;

  String get svgPath {
    switch (this) {
      case NotificationTypes.accepted:
        return SvgAssets.shield;
      case NotificationTypes.reminderAboutExpirationDate:
        return SvgAssets.clock;
      case NotificationTypes.expiryReminder:
        return SvgAssets.xShield;
      case NotificationTypes.paymentCompleted:
        return SvgAssets.creditCard;
    }
  }

  Color get svgColor {
    switch (this) {
      case NotificationTypes.accepted:
        return AppColors.secondary;
      case NotificationTypes.reminderAboutExpirationDate:
        return AppColors.primary;
      case NotificationTypes.expiryReminder:
        return AppColors.danger;
      case NotificationTypes.paymentCompleted:
        return AppColors.secondary;
    }
  }

  Color get svgBackgroundColor {
    switch (this) {
      case NotificationTypes.accepted:
        return AppColors.secondaryLight;
      case NotificationTypes.reminderAboutExpirationDate:
        return AppColors.primaryLight;
      case NotificationTypes.expiryReminder:
        return AppColors.primaryLight2;
      case NotificationTypes.paymentCompleted:
        return AppColors.secondaryLight;
    }
  }
}
