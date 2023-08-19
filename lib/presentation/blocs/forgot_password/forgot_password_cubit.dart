import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/usecases/forgot_password_usecase.dart';
import 'package:insurance_app/domain/usecases/reset_password_usecase.dart';
import 'package:insurance_app/domain/usecases/verify_forgot_password_otp_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());
  final GlobalKey<FormState> sendOtpForm = GlobalKey<FormState>();
  final TextEditingController emailOrPhoneNumberController =
      TextEditingController();

  final GlobalKey<FormState> verifyOtpForm = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> resetPasswordForm = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Timer? resendOtpTimer;
  void startTimer() {
    const timer = 120;
    emit(state.copyWith(
      resendCounterInSeconds: timer,
      isResendButtonActive: false,
    ));
    resendOtpTimer?.cancel();
    const oneSec = Duration(seconds: 1);
    int currentTimerCount = timer;
    resendOtpTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state.resendCounterInSeconds == 0) {
          resendOtpTimer?.cancel();
        } else {
          currentTimerCount--;
          emit(state.copyWith(
            resendCounterInSeconds: currentTimerCount,
            isResendButtonActive: currentTimerCount == 0 ? true : false,
          ));
        }
      },
    );
  }

  bool isEmailOrPhoneFieldValid() =>
      sendOtpForm.currentState?.validate() ?? false;

  Future<void> sendOtp() async {
    emit(
      state.copyWith(
          emailOrPhoneNumber: emailOrPhoneNumberController.text.trim(),
          sendOtpStatus: Status.loading),
    );
    initForgotPassword();
    (await instance<ForgotPasswordUsecase>()
            .execute(emailOrPhoneNumberController.text.trim()))
        .fold((failure) {
      emit(state.copyWith(
        sendOtpStatus: Status.failure,
        sendOtpError: failure.message,
      ));
    }, (data) {
      emit(state.copyWith(sendOtpStatus: Status.success));
      startTimer();
    });
  }

  bool isOtpFieldValid() => verifyOtpForm.currentState?.validate() ?? false;

  Future<void> verifyOtp() async {
    emit(state.copyWith(verifyOtpStatus: Status.loading));
    initVerifyForgotPasswordOtp();
    (await instance<VerifyForgotPasswordOtpUsecase>().execute(
            VerifyForgotPasswordOtpUsecaseInput(
                email: emailOrPhoneNumberController.text.trim(),
                otp: otpController.text.trim())))
        .fold((failure) {
      emit(state.copyWith(
        verifyOtpStatus: Status.failure,
        verifyOtpError: failure.message,
      ));
    }, (data) {
      emit(state.copyWith(verifyOtpStatus: Status.success));
    });
  }

  bool isResetPasswordFormValid() =>
      resetPasswordForm.currentState?.validate() ?? false;

  Future<void> resetPassword() async {
    emit(state.copyWith(resetPasswordStatus: Status.loading));
    initResetPassword();
    (await instance<ResetPasswordUsecase>().execute(ResetPasswordUsecaseInput(
      email: emailOrPhoneNumberController.text.trim(),
      otp: otpController.text.trim(),
      password: passwordController.text.trim(),
    )))
        .fold((failure) {
      emit(state.copyWith(
        resetPasswordStatus: Status.failure,
        resetPasswordError: failure.message,
      ));
    }, (data) {
      resendOtpTimer?.cancel();
      emit(state.copyWith(resetPasswordStatus: Status.success));
    });
  }

  Future<void> resendOtp() async {
    emit(
      state.copyWith(
          isResendButtonActive: false, resendOtpStatus: Status.loading),
    );
    initForgotPassword();
    (await instance<ForgotPasswordUsecase>()
            .execute(emailOrPhoneNumberController.text.trim()))
        .fold((failure) {
      emit(state.copyWith(
        resendOtpStatus: Status.failure,
        resendOtpError: failure.message,
        isResendButtonActive: true,
      ));
    }, (data) {
      startTimer();
      emit(state.copyWith(resendOtpStatus: Status.success));
    });
  }

  backFromResetPasswordStep() {
    passwordController.clear();
    confirmPasswordController.clear();
    emit(state.copyWith(
        resetPasswordStatus: Status.initial, verifyOtpStatus: Status.initial));
  }

  backFromVerifyOtpStep() {
    otpController.clear();
    resendOtpTimer?.cancel();
    emit(state.copyWith(
        verifyOtpStatus: Status.initial, sendOtpStatus: Status.initial));
  }
}
