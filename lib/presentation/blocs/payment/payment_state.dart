part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final PaymentMethod? paymentMethod;
  final InsuranceEntity? insurance;

  final String? phoneNumber;
  final Status sendOtpStatus;
  final String? sendOtpError;
  final Status verifyOtpStatus;
  final String? verifyOtpError;
  final int resendCounterInSeconds;
  final bool isResendButtonActive;
  final Status paymentStatus;
  final String? paymentErrorMessage;
  final Status getInsuranceInstallmentsStatus;
  final String? getInsuranceInstallmentsErrorMessage;
  final InsuranceInstallmentsEntity? insuranceInstallments;
  const PaymentState({
    this.paymentMethod,
    this.insurance,
    this.phoneNumber,
    this.sendOtpStatus = Status.initial,
    this.sendOtpError,
    this.verifyOtpStatus = Status.initial,
    this.verifyOtpError,
    this.resendCounterInSeconds = 0,
    this.isResendButtonActive = false,
    this.paymentStatus = Status.initial,
    this.paymentErrorMessage,
    this.getInsuranceInstallmentsStatus = Status.initial,
    this.getInsuranceInstallmentsErrorMessage,
    this.insuranceInstallments,
  });

  PaymentState copyWith({
    PaymentMethod? paymentMethod,
    InsuranceEntity? insurance,
    String? phoneNumber,
    Status? sendOtpStatus,
    String? sendOtpError,
    Status? verifyOtpStatus,
    String? verifyOtpError,
    int? resendCounterInSeconds,
    bool? isResendButtonActive,
    Status? paymentStatus,
    String? paymentErrorMessage,
    Status? getInsuranceInstallmentsStatus,
    String? getInsuranceInstallmentsErrorMessage,
    InsuranceInstallmentsEntity? insuranceInstallments,
  }) {
    return PaymentState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      insurance: insurance ?? this.insurance,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      sendOtpStatus: sendOtpStatus ?? this.sendOtpStatus,
      sendOtpError: sendOtpError ?? this.sendOtpError,
      verifyOtpStatus: verifyOtpStatus ?? this.verifyOtpStatus,
      verifyOtpError: verifyOtpError ?? this.verifyOtpError,
      resendCounterInSeconds:
          resendCounterInSeconds ?? this.resendCounterInSeconds,
      isResendButtonActive: isResendButtonActive ?? this.isResendButtonActive,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentErrorMessage: paymentErrorMessage ?? this.paymentErrorMessage,
      getInsuranceInstallmentsStatus:
          getInsuranceInstallmentsStatus ?? this.getInsuranceInstallmentsStatus,
      getInsuranceInstallmentsErrorMessage:
          getInsuranceInstallmentsErrorMessage ??
              this.getInsuranceInstallmentsErrorMessage,
      insuranceInstallments:
          insuranceInstallments ?? this.insuranceInstallments,
    );
  }

  @override
  List<Object?> get props {
    return [
      paymentMethod,
      insurance,
      phoneNumber,
      sendOtpStatus,
      sendOtpError,
      verifyOtpStatus,
      verifyOtpError,
      resendCounterInSeconds,
      isResendButtonActive,
      paymentStatus,
      paymentErrorMessage,
      getInsuranceInstallmentsStatus,
      getInsuranceInstallmentsErrorMessage,
      insuranceInstallments,
    ];
  }
}
