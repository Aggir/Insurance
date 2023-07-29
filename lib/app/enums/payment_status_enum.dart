import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

import '../app_strings.dart';

enum PaymentStatus {
  success,
  failed,
  onProcess,
}

extension PaymentStatusExtension on PaymentStatus {
  bool get isSuccess => this == PaymentStatus.success;
  bool get isFailed => this == PaymentStatus.failed;
  bool get isOnProcess => this == PaymentStatus.onProcess;

  String get string {
    switch (this) {
      case PaymentStatus.success:
        return AppStrings.success;
      case PaymentStatus.failed:
        return AppStrings.failed;
      case PaymentStatus.onProcess:
        return AppStrings.onProcess;
    }
  }

  Color get color {
    switch (this) {
      case PaymentStatus.success:
        return AppColors.secondary;
      case PaymentStatus.failed:
        return AppColors.danger;
      case PaymentStatus.onProcess:
        return AppColors.primaryLight;
    }
  }
}
