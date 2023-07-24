import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/enums.dart';

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
    const timer = 10;
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

  Future<void> confirmSendOtpForm() async {
    if (sendOtpForm.currentState!.validate()) {
      emit(
        state.copyWith(
            emailOrPhoneNumber: emailOrPhoneNumberController.text,
            sendOtpStatus: Status.loading),
      );
      // Todo: send Otp
      await Future.delayed(const Duration(seconds: 1));
      if (emailOrPhoneNumberController.text == "0921234567") {
        emit(
          state.copyWith(sendOtpStatus: Status.success),
        );
        startTimer();
      } else {
        emit(state.copyWith(
            sendOtpStatus: Status.failure,
            sendOtpError: "رقم الهاتف او البريد الالكتروني غير صحيح."));
      }
    }
  }

  Future<void> confirmVerifyOtpForm() async {
    if (verifyOtpForm.currentState!.validate()) {
      emit(state.copyWith(verifyOtpStatus: Status.loading));
      // Todo: verify Otp
      await Future.delayed(const Duration(seconds: 1));
      if (otpController.text == '1234') {
        emit(state.copyWith(verifyOtpStatus: Status.success));
      } else {
        emit(state.copyWith(
            verifyOtpStatus: Status.failure,
            verifyOtpError: "رقم التحقق غير صحيح"));
      }
    }
  }

  Future<void> confirmResetPasswordForm() async {
    if (resetPasswordForm.currentState!.validate()) {
      emit(state.copyWith(resetPasswordStatus: Status.loading));
      // Todo: verify Otp
      await Future.delayed(const Duration(seconds: 1));
      if (true) {
        emit(state.copyWith(resetPasswordStatus: Status.success));
      }
      //  else {
      //   emit(state.copyWith(
      //       resetPasswordStatus: Status.failure, resetPasswordError: ""));
      // }
    }
  }

  backFromResetPasswordStep() {
    passwordController.clear();
    confirmPasswordController.clear();
    emit(state.copyWith(
        resetPasswordStatus: Status.initial, verifyOtpStatus: Status.initial));
  }

  backFromVerifyOtpStep() {
    otpController.clear();
    emit(state.copyWith(
        verifyOtpStatus: Status.initial, sendOtpStatus: Status.initial));
  }
}
