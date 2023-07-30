import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(const ReminderState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  void setSelectedType(String selectedType) {
    emit(state.copyWith(selectedType: selectedType));
  }

  void setSelectedTime(String selectedTime) {
    emit(state.copyWith(selectedTime: selectedTime));
  }

  void setEndDate() {
    DateTime startDateTime =
        DateFormat('dd-M-yyyy').parse(startDateController.text);
    endDateController.text = DateFormat('dd-M-yyyy').format(DateTime(
        startDateTime.year + 1, startDateTime.month, startDateTime.day));
  }

  bool confirmStepOne() => formKey.currentState!.validate();

  uploadInsurancePicture() async {
    emit(state.copyWith(insurancePictureStatus: Status.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(insurancePictureStatus: Status.success));
  }

  removeInsurancePicture() {
    emit(state.copyWith(insurancePictureStatus: Status.initial));
  }

  backFromUploadInsurancePicture() {
    removeInsurancePicture();
  }
}
