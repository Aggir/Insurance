import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'issue_insurance_state.dart';

class IssueInsuranceCubit extends Cubit<IssueInsuranceState> {
  IssueInsuranceCubit() : super(const IssueInsuranceState());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  setSelectedCompany(String selectedCompany) {
    emit(state.copyWith(selectedCompany: selectedCompany));
  }

  setSelectedType(String selectedType) {
    emit(state.copyWith(selectedType: selectedType));
  }

  setSelectedVehicle(String selectedVehicle) {
    emit(state.copyWith(selectedVehicle: selectedVehicle));
  }

  setEndDate() {
    DateTime startDateTime =
        DateFormat('dd-M-yyyy').parse(startDateController.text);
    endDateController.text = DateFormat('dd-M-yyyy').format(DateTime(
        startDateTime.year + 1, startDateTime.month, startDateTime.day));
  }

  confirmStepOne() => formKey.currentState!.validate();
}
