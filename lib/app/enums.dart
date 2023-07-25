import 'package:insurance_app/app/app_strings.dart';

enum Status {
  initial,
  loading,
  success,
  failure,
}

extension StatusExtension on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}

enum SignUpVerificationTypes {
  passport,
  idCard,
  nationalIdNumber,
}

extension SignUpVerificationTypesExtension on SignUpVerificationTypes {
  bool get isPassport => this == SignUpVerificationTypes.passport;
  bool get isIdCard => this == SignUpVerificationTypes.idCard;
  bool get isNationalIdNumber =>
      this == SignUpVerificationTypes.nationalIdNumber;
}

enum PaymentStatus {
  success,
  failed,
  onProcess,
}

extension PaymentStatusExtension on PaymentStatus {
  bool get isSuccess => this == PaymentStatus.success;
  bool get isFailed => this == PaymentStatus.failed;
  bool get isOnProcess => this == PaymentStatus.onProcess;

  String get string => this == PaymentStatus.success
      ? AppStrings.success
      : this == PaymentStatus.failed
          ? AppStrings.failed
          : AppStrings.onProcess;
}
