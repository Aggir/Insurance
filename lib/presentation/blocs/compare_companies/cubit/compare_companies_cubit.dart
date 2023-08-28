import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/company_price.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/usecases/compare_companies_prices_usecase.dart';
import 'package:insurance_app/domain/usecases/get_insurance_types_usecase.dart';

part 'compare_companies_state.dart';

class CompareCompaniesCubit extends Cubit<CompareCompaniesState> {
  CompareCompaniesCubit() : super(const CompareCompaniesState());

  final TextEditingController searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  bool isDisposed = false;

  fetchInsuranceTypes() async {
    emit(state.copyWith(fetchInsuranceTypesStatus: Status.loading));
    initGetInsuranceTypes();
    (await instance<GetInsuranceTypesUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
            fetchInsuranceTypesStatus: Status.failure,
            fetchInsuranceTypesErrorMessage: failure.message)),
        (data) => emit(state.copyWith(
              fetchInsuranceTypesStatus: Status.success,
              insuranceTypes: data,
            )));
  }

  selectHorsePower(int horsePower) {
    emit(state.copyWith(horsePower: horsePower));
  }

  selectInsuranceType(int insuranceTypeId) {
    emit(state.copyWith(insuranceTypeId: insuranceTypeId));
  }

  selectMaxPassengers(int maxPassengers) {
    emit(state.copyWith(maxPassengers: maxPassengers));
  }

  setIsSortByMinimum(bool value) {
    emit(state.copyWith(isSortByMinimum: value));
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
      insuranceTypeId: state.insuranceTypeId!,
      horsePower: state.horsePower!,
      maxPassengers: state.maxPassengers!,
      isSortByMinimum: state.isSortByMinimum,
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
