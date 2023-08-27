import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/insurance_types_enum.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/meta.dart';
import 'package:insurance_app/domain/usecases/get_my_insurances_usecase.dart';

part 'my_insurances_state.dart';

class MyInsurancesCubit extends Cubit<MyInsurancesState> {
  MyInsurancesCubit() : super(const MyInsurancesState());

  final ScrollController processingScrollController = ScrollController();
  final ScrollController activeScrollController = ScrollController();
  final ScrollController notPaidScrollController = ScrollController();
  final ScrollController expiredScrollController = ScrollController();
  bool isDisposed = false;

  init() async {
    emit(state.copyWith(fetchInsurancesStatus: Status.loading));
    initGetMyInsurances();
    (await instance<GetMyInsurancesUsecase>().execute(null)).fold((failure) {
      if (!isDisposed) {
        emit(state.copyWith(
            fetchInsurancesStatus: Status.failure,
            fetchInsurancesErrorMessage: failure.message));
      }
    }, (data) {
      if (!isDisposed) {
        emit(state.copyWith(
          fetchInsurancesStatus: Status.success,
          insurances: data.insurances,
          processingInsurances: data.insurances
              ?.where((insurance) =>
                  insurance.insuranceTypeStatus.isUnderProcessing)
              .toList(),
          activeInsurances: data.insurances
              ?.where((insurance) => insurance.insuranceTypeStatus.isIssued)
              .toList(),
          notPaidInsurances: data.insurances
              ?.where((insurance) => insurance.insuranceTypeStatus.isNotPaid)
              .toList(),
          expiredInsurances: data.insurances
              ?.where((insurance) => insurance.insuranceTypeStatus.isExpired)
              .toList(),
          meta: data.meta,
        ));
      }
    });

    processingScrollController.addListener(() async {
      await _fetchMore(processingScrollController);
    });
    activeScrollController.addListener(() async {
      await _fetchMore(activeScrollController);
    });
    notPaidScrollController.addListener(() async {
      await _fetchMore(notPaidScrollController);
    });
    expiredScrollController.addListener(() async {
      await _fetchMore(expiredScrollController);
    });
  }

  _fetchMore(ScrollController scrollController) async {
    if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels &&
        !state.fetchMoreInsurancesStatus.isLoading) {
      if (state.meta != null &&
          state.meta!.currentPage < state.meta!.lastPage) {
        if (!isDisposed) {
          emit(state.copyWith(fetchMoreInsurancesStatus: Status.loading));
          initGetMyInsurances();
          (await instance<GetMyInsurancesUsecase>()
                  .execute(state.meta!.currentPage + 1))
              .fold((failure) {
            if (!isDisposed) {
              emit(state.copyWith(
                  fetchMoreInsurancesStatus: Status.failure,
                  fetchMoreInsurancesErrorMessage: failure.message));
            }
          }, (data) {
            if (!isDisposed) {
              emit(state.copyWith(
                fetchMoreInsurancesStatus: Status.success,
                insurances: [...state.insurances!, ...data.insurances!],
                processingInsurances: [
                  ...state.insurances!,
                  ...data.insurances!
                      .where((insurance) =>
                          insurance.insuranceTypeStatus.isUnderProcessing)
                      .toList()
                ],
                activeInsurances: [
                  ...state.insurances!,
                  ...data.insurances!
                      .where(
                          (insurance) => insurance.insuranceTypeStatus.isIssued)
                      .toList()
                ],
                notPaidInsurances: [
                  ...state.insurances!,
                  ...data.insurances!
                      .where((insurance) =>
                          insurance.insuranceTypeStatus.isNotPaid)
                      .toList()
                ],
                expiredInsurances: [
                  ...state.insurances!,
                  ...data.insurances!
                      .where((insurance) =>
                          insurance.insuranceTypeStatus.isExpired)
                      .toList()
                ],
                meta: data.meta,
              ));
            }
          });
        }
      }
    }
  }

  @override
  Future<void> close() {
    isDisposed = true;
    return super.close();
  }
}
