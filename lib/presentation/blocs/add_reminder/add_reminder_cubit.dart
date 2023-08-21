import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/alarm_type.dart';
import 'package:insurance_app/domain/usecases/add_alarm_usecase.dart';
import 'package:insurance_app/domain/usecases/get_alarm_types_usecase.dart';

part 'add_reminder_state.dart';

class AddReminderCubit extends Cubit<AddReminderState> {
  AddReminderCubit() : super(const AddReminderState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Future<void> fetchAlarmTypes() async {
    emit(state.copyWith(fetchAlarmTypesStatus: Status.loading));
    initGetAlarmTypes();
    (await instance<GetAlarmTypesUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
              fetchAlarmTypesStatus: Status.failure,
              fetchAlarmTypesErrorMessage: failure.message,
            )),
        (alarmTypes) => emit(state.copyWith(
              fetchAlarmTypesStatus: Status.success,
              alarmTypes: alarmTypes,
            )));
  }

  void setSelectedType(int selectedType) {
    emit(state.copyWith(selectedTypeId: selectedType));
  }

  void setSelectedTime(int selectedTime) {
    emit(state.copyWith(selectedTime: selectedTime));
  }

  void setEndDate() {
    DateTime startDateTime =
        DateFormat('yyyy-MM-dd').parse(startDateController.text);
    endDateController.text = DateFormat('yyyy-MM-dd').format(DateTime(
        startDateTime.year + 1, startDateTime.month, startDateTime.day));
  }

  bool confirmStepOne() => formKey.currentState!.validate();

  uploadInsurancePicture() async {
    emit(state.copyWith(insurancePictureStatus: Status.loading));
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: Constants.allowedDocumentExtensions,
    );
    if (result != null) {
      final PlatformFile firstFile = result.files.first;
      emit(state.copyWith(
        insurancePictureName: firstFile.name,
        insurancePictureStatus: Status.success,
        insurancePicture: File(firstFile.path!),
      ));
    } else {
      emit(state.copyWith(insurancePictureStatus: Status.initial));
    }
  }

  addReminder() async {
    emit(state.copyWith(addReminderStatus: Status.loading));
    initAddAlarm();
    (await instance<AddAlarmUsecase>().execute(AddAlarmUsecaseInput(
            startDate: startDateController.text,
            endDate: endDateController.text,
            remindTime: state.selectedTime!,
            insurancePicture: state.insurancePicture!,
            alarmTypeId: state.selectedTypeId!)))
        .fold(
      (failure) => emit(state.copyWith(
          addReminderStatus: Status.failure,
          addReminderErrorMessage: failure.message)),
      (r) => emit(state.copyWith(addReminderStatus: Status.success)),
    );
  }

  removeInsurancePicture() {
    emit(state.copyWith(
      insurancePictureStatus: Status.initial,
      removePicture: true,
    ));
  }

  backFromUploadInsurancePicture() {
    removeInsurancePicture();
  }
}
