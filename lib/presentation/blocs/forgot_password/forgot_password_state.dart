part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final String? emailOrPhoneNumber;
  final Status sendOtpStatus;
  final String? sendOtpError;
  final Status verifyOtpStatus;
  final String? verifyOtpError;
  final Status resetPasswordStatus;
  final String? resetPasswordError;
  final Status resendOtpStatus;
  final String? resendOtpError;
  final int resendCounterInSeconds;
  final bool isResendButtonActive;
  const ForgotPasswordState({
    this.emailOrPhoneNumber,
    this.sendOtpStatus = Status.initial,
    this.sendOtpError,
    this.verifyOtpStatus = Status.initial,
    this.verifyOtpError,
    this.resetPasswordStatus = Status.initial,
    this.resetPasswordError,
    this.resendOtpStatus = Status.initial,
    this.resendOtpError,
    this.resendCounterInSeconds = 0,
    this.isResendButtonActive = false,
  });

  ForgotPasswordState copyWith({
    String? emailOrPhoneNumber,
    Status? sendOtpStatus,
    String? sendOtpError,
    Status? verifyOtpStatus,
    String? verifyOtpError,
    Status? resetPasswordStatus,
    String? resetPasswordError,
    Status? resendOtpStatus,
    String? resendOtpError,
    int? resendCounterInSeconds,
    bool? isResendButtonActive,
  }) {
    return ForgotPasswordState(
      emailOrPhoneNumber: emailOrPhoneNumber ?? this.emailOrPhoneNumber,
      sendOtpStatus: sendOtpStatus ?? this.sendOtpStatus,
      sendOtpError: sendOtpError ?? this.sendOtpError,
      verifyOtpStatus: verifyOtpStatus ?? this.verifyOtpStatus,
      verifyOtpError: verifyOtpError ?? this.verifyOtpError,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      resetPasswordError: resetPasswordError ?? this.resetPasswordError,
      resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
      resendOtpError: resendOtpError ?? this.resendOtpError,
      resendCounterInSeconds:
          resendCounterInSeconds ?? this.resendCounterInSeconds,
      isResendButtonActive: isResendButtonActive ?? this.isResendButtonActive,
    );
  }

  @override
  List<Object?> get props {
    return [
      emailOrPhoneNumber,
      sendOtpStatus,
      sendOtpError,
      verifyOtpStatus,
      verifyOtpError,
      resetPasswordStatus,
      resetPasswordError,
      resendOtpStatus,
      resendOtpError,
      resendCounterInSeconds,
      isResendButtonActive,
    ];
  }
}
