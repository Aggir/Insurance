import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/payment_method_enum.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/data_classes/payment_step_parameters.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/insurance_installments.dart';
import 'package:insurance_app/domain/usecases/get_insurance_installments_usecase.dart';
import 'package:insurance_app/domain/usecases/pay_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());

  setPaymentStepParams(PaymentStepParameters paymentParams) {
    emit(state.copyWith(
      paymentMethod: paymentParams.paymentMethod,
      insurance: paymentParams.insurance,
    ));
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

  getInsuranceInstallments(
      {required int userId, required InsuranceEntity insurance}) async {
    emit(state.copyWith(getInsuranceInstallmentsStatus: Status.loading));
    initGetInsuranceInstallments();
    (await instance<GetInsuranceInstallmentsUsecase>().execute(
      GetInsuranceInstallmentsUsecaseInput(
        companyId: insurance.company.id,
        serviceId: 1,
        subServiceId: 1,
        userId: userId,
        value: double.parse(insurance.cost),
      ),
    ))
        .fold(
      (failure) => emit(
        state.copyWith(
          getInsuranceInstallmentsStatus: Status.failure,
          getInsuranceInstallmentsErrorMessage: failure.message,
        ),
      ),
      (data) => emit(
        state.copyWith(
          getInsuranceInstallmentsStatus: Status.success,
          insuranceInstallments: data,
        ),
      ),
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
        emit(state.copyWith(verifyOtpStatus: Status.success));
      } else {
        emit(state.copyWith(
            verifyOtpStatus: Status.failure,
            verifyOtpError: "رقم التحقق غير صحيح"));
      }
    }
  }

  Future<void> pay() async {
    //TODO: DELETE THIS FUNCTION!!
    emit(state.copyWith(paymentStatus: Status.loading));
    initPay();
    (await instance<PayUsecase>().execute(state.insurance!.id)).fold(
      (failure) => emit(state.copyWith(
          paymentStatus: Status.failure, paymentErrorMessage: failure.message)),
      (_) {
        resendOtpTimer?.cancel();
        emit(state.copyWith(paymentStatus: Status.success));
      },
    );
  }

  backFromVerifyOtpStep() {
    otpController.clear();
    resendOtpTimer?.cancel();
    emit(state.copyWith(
        verifyOtpStatus: Status.initial, sendOtpStatus: Status.initial));
  }
}
