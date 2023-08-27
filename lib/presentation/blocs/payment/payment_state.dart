part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final PaymentMethod? paymentMethod;
  final int? insuranceId;

  final String? phoneNumber;
  final Status sendOtpStatus;
  final String? sendOtpError;
  final Status verifyOtpStatus;
  final String? verifyOtpError;
  final int resendCounterInSeconds;
  final bool isResendButtonActive;
  final Status paymentStatus;
  final String? paymentErrorMessage;
  const PaymentState({
    this.paymentMethod,
    this.insuranceId,
    this.phoneNumber,
    this.sendOtpStatus = Status.initial,
    this.sendOtpError,
    this.verifyOtpStatus = Status.initial,
    this.verifyOtpError,
    this.resendCounterInSeconds = 0,
    this.isResendButtonActive = false,
    this.paymentStatus = Status.initial,
    this.paymentErrorMessage,
  });

  PaymentState copyWith({
    PaymentMethod? paymentMethod,
    int? insuranceId,
    String? phoneNumber,
    Status? sendOtpStatus,
    String? sendOtpError,
    Status? verifyOtpStatus,
    String? verifyOtpError,
    int? resendCounterInSeconds,
    bool? isResendButtonActive,
    Status? paymentStatus,
    String? paymentErrorMessage,
  }) {
    return PaymentState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      insuranceId: insuranceId ?? this.insuranceId,
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
    );
  }

  @override
  List<Object?> get props {
    return [
      paymentMethod,
      insuranceId,
      phoneNumber,
      sendOtpStatus,
      sendOtpError,
      verifyOtpStatus,
      verifyOtpError,
      resendCounterInSeconds,
      isResendButtonActive,
      paymentStatus,
      paymentErrorMessage,
    ];
  }
}
