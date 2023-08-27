import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/data_classes/company_prices_form_data.dart';
import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/domain/entities/meta.dart';
import 'package:insurance_app/domain/usecases/calculate_insurance_price_usecase.dart';
import 'package:insurance_app/domain/usecases/get_companies_usecase.dart';
import 'package:insurance_app/domain/usecases/get_company_prices_form_usecase.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit() : super(const CompaniesState());

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  bool isDisposed = false;

  selectCompany(CompanyEntity company) {
    emit(state.copyWith(selectedCompany: company));
  }

  clearSearch() {
    searchController.clear();
    searchFocusNode.unfocus();
    emit(state.copyWith(filteredCompanies: state.companies));
  }

  fetchPricesFormData() async {
    emit(state.copyWith(
        calculatePriceStatus: Status.initial,
        fetchPricesFormDataStatus: Status.loading));
    initGetCompanyPricesFormData();
    (await instance<GetCompanyPricesFormUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
            fetchPricesFormDataStatus: Status.failure,
            fetchPricesFormDataErrorMessage: failure.message)),
        (data) => emit(state.copyWith(
            fetchPricesFormDataStatus: Status.success,
            companyPricesFormData: data)));
  }

  calculatePrice() async {
    emit(state.copyWith(calculatePriceStatus: Status.loading));
    initCalculateInsurancePrice();
    (await instance<CalculateInsurancePriceUsecase>().execute(
            CalculateInsurancePriceUsecaseInput(
                companyId: state.selectedCompany!.id,
                insuranceTypeId: state.insuranceTypeId!,
                vehicleId: state.insuranceTypeId!)))
        .fold(
            (failure) => emit(state.copyWith(
                calculatePriceStatus: Status.failure,
                calculatePriceErrorMessage: failure.message)),
            (data) => emit(state.copyWith(
                calculatePriceStatus: Status.success, price: data)));
  }

  selectVehicleBrand(int vehicleBrandId) {
    emit(state.copyWith(
      vehicleBrandId: vehicleBrandId,
      calculatePriceStatus: Status.initial,
    ));
  }

  selectInsuranceType(int insuranceTypeId) {
    emit(state.copyWith(
      insuranceTypeId: insuranceTypeId,
      calculatePriceStatus: Status.initial,
    ));
  }

  selectSeatsCount(int seatsCount) {
    emit(state.copyWith(
      seatsCount: seatsCount,
      calculatePriceStatus: Status.initial,
    ));
  }

  selectHorsePower(int horsePower) {
    emit(state.copyWith(
      horsePower: horsePower,
      calculatePriceStatus: Status.initial,
    ));
  }

  fetchCompanies() async {
    emit(state.copyWith(fetchCompaniesStatus: Status.loading));
    initGetCompanies();
    (await instance<GetCompaniesUsecase>().execute(null)).fold(
      (failure) => emit(state.copyWith(
        fetchCompaniesStatus: Status.failure,
        fetchCompaniesErrorMessage: failure.message,
      )),
      (companiesPage) => emit(state.copyWith(
        fetchCompaniesStatus: Status.success,
        companies: companiesPage.companies,
        filteredCompanies: companiesPage.companies
            .where((company) => company.name.contains(searchController.text))
            .toList(),
        meta: companiesPage.meta,
      )),
    );
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          !state.fetchMoreCompaniesStatus.isLoading) {
        if (state.meta != null &&
            state.meta!.currentPage < state.meta!.lastPage) {
          if (!isDisposed) {
            emit(state.copyWith(fetchMoreCompaniesStatus: Status.loading));
            initGetMyVehicles();
            (await instance<GetCompaniesUsecase>()
                    .execute(state.meta!.currentPage + 1))
                .fold((failure) {
              emit(state.copyWith(
                  fetchMoreCompaniesStatus: Status.failure,
                  fetchMoreCompaniesErrorMessage: failure.message));
            }, (data) {
              emit(state.copyWith(
                fetchMoreCompaniesStatus: Status.success,
                companies: [...state.companies!, ...data.companies],
                filteredCompanies: [
                  ...state.filteredCompanies!,
                  ...data.companies
                      .where((company) =>
                          company.name.contains(searchController.text))
                      .toList()
                ],
                meta: data.meta,
              ));
            });
          }
        }
      }
    });
  }

  setFilterCompanies(String? text) {
    List<CompanyEntity> filteredCompanies = state.companies
            ?.where((element) => element.name.contains(text?.trim() ?? ''))
            .toList() ??
        [];
    emit(state.copyWith(filteredCompanies: filteredCompanies));
  }

  @override
  Future<void> close() {
    isDisposed = true;
    return super.close();
  }
}
