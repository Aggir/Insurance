import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/data_classes/company_prices_form_data.dart';
import 'package:insurance_app/domain/entities/company_price.dart';
import 'package:insurance_app/domain/usecases/compare_companies_prices_usecase.dart';
import 'package:insurance_app/domain/usecases/get_company_prices_form_usecase.dart';

part 'compare_companies_state.dart';

class CompareCompaniesCubit extends Cubit<CompareCompaniesState> {
  CompareCompaniesCubit() : super(const CompareCompaniesState());

  final TextEditingController searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  final GlobalKey<FormState> filterFormKey = GlobalKey<FormState>();
  final TextEditingController horsepowerController = TextEditingController();
  final TextEditingController maxPassengersController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  bool isDisposed = false;

  fetchCompareCompaniesFormData() async {
    emit(state.copyWith(fetchPricesFormDataStatus: Status.loading));
    initGetCompanyPricesFormData();
    (await instance<GetCompanyPricesFormUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
            fetchPricesFormDataStatus: Status.failure,
            fetchPricesFormDataErrorMessage: failure.message)),
        (data) => emit(state.copyWith(
            fetchPricesFormDataStatus: Status.success,
            companyPricesFormData: data)));
  }

  toggleWithAttachment() {
    emit(state.copyWith(withAttachment: !(state.withAttachment ?? false)));
  }

  selectInsuranceType(int insuranceTypeId) {
    emit(state.copyWith(selectedInsuranceTypeId: insuranceTypeId));
  }

  selectVehicleType(int vehicleTypeId) {
    emit(state.copyWith(selectedVehicleTypeId: vehicleTypeId));
  }

  setIsSortByMinimum(bool value) {
    emit(state.copyWith(isSortByMinimum: value));
  }

  clearFilter() {
    horsepowerController.clear();
    weightController.clear();
    maxPassengersController.clear();
    emit(state.copyWith(clearFilter: true));
  }

  clear() {
    searchController.clear();
    emit(const CompareCompaniesState());
  }

  fetchCompaniesPrices() async {
    emit(state.copyWith(fetchCompaniesPricesStatus: Status.loading));
    initCompareCompaniesPrices();
    (await instance<CompareCompaniesPricesUsecase>()
            .execute(CompareCompaniesPricesUsecaseInput(
      insuranceTypeId: state.selectedInsuranceTypeId!,
      horsePower: horsepowerController.text.trim(),
      maxPassengers: maxPassengersController.text.trim(),
      isSortByMinimum: state.isSortByMinimum,
      vehicleTypeId: state.selectedVehicleTypeId!,
      weight: weightController.text.trim(),
      withAttachment: state.withAttachment,
    )))
        .fold(
      (failure) => emit(state.copyWith(
          fetchCompaniesPricesStatus: Status.failure,
          fetchCompaniesPricesErrorMessage: failure.message)),
      (data) => emit(
        state.copyWith(
          fetchCompaniesPricesStatus: Status.success,
          companiesPrices: data,
          filteredCompaniesPrices: data
              .where(
                  (e) => e.company.name.contains(searchController.text.trim()))
              .toList(),
        ),
      ),
    );
  }

  setFilterCompaniesPrices(String? text) {
    List<CompanyPriceEntity> filteredList = state.companiesPrices
            ?.where(
                (element) => element.company.name.contains(text?.trim() ?? ''))
            .toList() ??
        [];
    emit(state.copyWith(filteredCompaniesPrices: filteredList));
  }
}
