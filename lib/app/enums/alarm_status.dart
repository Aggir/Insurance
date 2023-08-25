import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

enum AlarmStatus {
  active,
  near,
  expired,
}

extension AlarmStatusExtension on AlarmStatus {
  bool get isActive => this == AlarmStatus.active;
  bool get isNear => this == AlarmStatus.near;
  bool get isExpired => this == AlarmStatus.expired;
}

extension StringToAlarmStatusExtension on String {
  AlarmStatus toAlarmStatus() {
    switch (toLowerCase()) {
      case 'active':
        return AlarmStatus.active;
      case 'near':
        return AlarmStatus.near;
      case 'expired':
      default:
        return AlarmStatus.expired;
    }
  }
}

extension ColorAlarmStatusExtension on AlarmStatus {
  Color getColor() {
    switch (this) {
      case AlarmStatus.active:
        return AppColors.secondary;
      case AlarmStatus.near:
        return AppColors.primaryLight;
      case AlarmStatus.expired:
        return AppColors.danger;
    }
  }
}
