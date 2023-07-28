part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final PaymentMethod? paymentMethod;

  final String? phoneNumber;
  final Status sendOtpStatus;
  final String? sendOtpError;
  final Status verifyOtpStatus;
  final String? verifyOtpError;
  final int resendCounterInSeconds;
  final bool isResendButtonActive;
  const PaymentState({
    this.paymentMethod,
    this.phoneNumber,
    this.sendOtpStatus = Status.initial,
    this.sendOtpError,
    this.verifyOtpStatus = Status.initial,
    this.verifyOtpError,
    this.resendCounterInSeconds = 0,
    this.isResendButtonActive = false,
  });

  PaymentState copyWith({
    PaymentMethod? paymentMethod,
    String? phoneNumber,
    Status? sendOtpStatus,
    String? sendOtpError,
    Status? verifyOtpStatus,
    String? verifyOtpError,
    int? resendCounterInSeconds,
    bool? isResendButtonActive,
  }) {
    return PaymentState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      sendOtpStatus: sendOtpStatus ?? this.sendOtpStatus,
      sendOtpError: sendOtpError ?? this.sendOtpError,
      verifyOtpStatus: verifyOtpStatus ?? this.verifyOtpStatus,
      verifyOtpError: verifyOtpError ?? this.verifyOtpError,
      resendCounterInSeconds:
          resendCounterInSeconds ?? this.resendCounterInSeconds,
      isResendButtonActive: isResendButtonActive ?? this.isResendButtonActive,
    );
  }

  @override
  List<Object?> get props {
    return [
      paymentMethod,
      phoneNumber,
      sendOtpStatus,
      sendOtpError,
      verifyOtpStatus,
      verifyOtpError,
      resendCounterInSeconds,
      isResendButtonActive,
    ];
  }
}
