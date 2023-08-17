import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/domain/entities/meta.dart';
import 'package:insurance_app/domain/usecases/get_companies_usecase.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit() : super(const CompaniesState());

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  bool isDisposed = false;

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
        companies: companiesPage.companies
          ..sort((a, b) => b.priority.compareTo(a.priority)),
        filteredCompanies: companiesPage.companies
          ..sort((a, b) => b.priority.compareTo(a.priority)),
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
                companies: [...state.companies!, ...data.companies]
                  ..sort((a, b) => a.priority.compareTo(b.priority)),
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
