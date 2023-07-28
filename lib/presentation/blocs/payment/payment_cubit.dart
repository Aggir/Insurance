import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());

  setSelectedPaymentMethod(PaymentMethod paymentMethod) {
    emit(state.copyWith(paymentMethod: paymentMethod));
  }

  final GlobalKey<FormState> sendOtpForm = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> verifyOtpForm = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

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
            phoneNumber: phoneNumberController.text,
            sendOtpStatus: Status.loading),
      );
      // Todo: send Otp
      await Future.delayed(const Duration(seconds: 1));
      emit(
        state.copyWith(sendOtpStatus: Status.success),
      );
      startTimer();
    }
  }

  Future<void> confirmVerifyOtpForm() async {
    if (verifyOtpForm.currentState!.validate()) {
      emit(state.copyWith(verifyOtpStatus: Status.loading));
      // Todo: verify Otp
      await Future.delayed(const Duration(seconds: 1));
      if (otpController.text == '1234') {
        resendOtpTimer?.cancel();
        emit(state.copyWith(verifyOtpStatus: Status.success));
      } else {
        emit(state.copyWith(
            verifyOtpStatus: Status.failure,
            verifyOtpError: "رقم التحقق غير صحيح"));
      }
    }
  }

  backFromVerifyOtpStep() {
    otpController.clear();
    resendOtpTimer?.cancel();
    emit(state.copyWith(
        verifyOtpStatus: Status.initial, sendOtpStatus: Status.initial));
  }
}
