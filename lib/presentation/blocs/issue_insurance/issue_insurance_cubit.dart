import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/data_classes/issue_insurance_form_data.dart';
import 'package:insurance_app/domain/usecases/calculate_insurance_price_usecase.dart';
import 'package:insurance_app/domain/usecases/get_insurance_form_data.dart';
import 'package:insurance_app/domain/usecases/issue_insurance_usecase.dart';
import 'package:intl/intl.dart';

part 'issue_insurance_state.dart';

class IssueInsuranceCubit extends Cubit<IssueInsuranceState> {
  IssueInsuranceCubit() : super(const IssueInsuranceState());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  fetchInsuranceFormData() async {
    emit(state.copyWith(fetchInsuranceFormDataStatus: Status.loading));
    initGetInsuranceFormData();
    (await instance<GetInsuranceFormData>().execute(null)).fold(
      (failure) => emit(state.copyWith(
          fetchInsuranceFormDataStatus: Status.failure,
          fetchInsuranceFormDataErrorMessage: failure.message)),
      (data) => emit(state.copyWith(
          fetchInsuranceFormDataStatus: Status.success,
          insuranceFormData: data)),
    );
  }

  calculateInsurancePrice() async {
    emit(state.copyWith(calculateInsurancePriceStatus: Status.loading));
    initCalculateInsurancePrice();
    (await instance<CalculateInsurancePriceUsecase>()
            .execute(CalculateInsurancePriceUsecaseInput(
      companyId: state.selectedCompanyId!,
      insuranceTypeId: state.selectedTypeId!,
      vehicleId: state.selectedVehicleId!,
    )))
        .fold(
            (failure) => emit(state.copyWith(
                calculateInsurancePriceStatus: Status.failure,
                calculateInsurancePriceErrorMessage: failure.message)), (data) {
      emit(state.copyWith(
        calculateInsurancePriceStatus: Status.success,
        insurancePrice: data,
      ));
    });
  }

  issueInsurance() async {
    emit(state.copyWith(issueInsuranceStatus: Status.loading));
    initIssueInsurance();
    (await instance<IssueInsuranceUsecase>().execute(IssueInsuranceUsecaseInput(
      companyId: state.selectedCompanyId!,
      insuranceTypeId: state.selectedTypeId!,
      vehicleId: state.selectedVehicleId!,
      startDate: startDateController.text,
      endDate: endDateController.text,
    )))
        .fold(
            (failure) => emit(
                  state.copyWith(
                      issueInsuranceStatus: Status.failure,
                      issueInsuranceErrorMessage: failure.message),
                ), (data) {
      emit(state.copyWith(
        issueInsuranceStatus: Status.success,
      ));
    });
  }

  setSelectedCompany(int? selectedCompany) {
    emit(state.copyWith(selectedCompanyId: selectedCompany));
  }

  setSelectedType(int? selectedType) {
    emit(state.copyWith(selectedTypeId: selectedType));
  }

  setSelectedVehicle(int? selectedVehicle) {
    emit(state.copyWith(selectedVehicleId: selectedVehicle));
  }

  setEndDate() {
    DateTime startDateTime =
        DateFormat('yyyy-MM-dd').parse(startDateController.text);
    endDateController.text = DateFormat('yyyy-MM-dd').format(DateTime(
        startDateTime.year + 1, startDateTime.month, startDateTime.day));
  }

  confirmStepOne() => formKey.currentState!.validate();
}
