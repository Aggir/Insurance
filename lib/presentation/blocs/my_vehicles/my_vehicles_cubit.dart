import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/domain/entities/meta.dart';
import 'package:insurance_app/domain/entities/vehicle.dart';
import 'package:insurance_app/domain/usecases/get_my_vehicles_usecase.dart';

import '../../../app/enums/status_enum.dart';

part 'my_vehicles_state.dart';

class MyVehiclesCubit extends Cubit<MyVehiclesState> {
  MyVehiclesCubit() : super(const MyVehiclesState());

  final ScrollController myVehiclesScrollController = ScrollController();
  final ScrollController hiddenVehiclesScrollController = ScrollController();
  bool isDisposed = false;

  init() async {
    emit(state.copyWith(fetchMyVehiclesStatus: Status.loading));
    initGetMyVehicles();
    (await instance<GetMyVehiclesUsecase>()
            .execute(GetMyVehiclesUsecaseInput()))
        .fold((failure) {
      if (!isDisposed) {
        emit(state.copyWith(
          fetchMyVehiclesStatus: Status.failure,
          fetchMyVehiclesErrorMessage: failure.message,
        ));
      }
    }, (data) {
      if (!isDisposed) {
        emit(state.copyWith(
          fetchMyVehiclesStatus: Status.success,
          myVehicles: data.vehicles,
          meta: data.meta,
        ));
      }
    });

    myVehiclesScrollController.addListener(() async {
      if (myVehiclesScrollController.position.maxScrollExtent ==
              myVehiclesScrollController.position.pixels &&
          !state.fetchMoreVehiclesStatus.isLoading) {
        if (state.meta != null &&
            state.meta!.currentPage < state.meta!.lastPage) {
          if (!isDisposed) {
            emit(state.copyWith(fetchMoreVehiclesStatus: Status.loading));
            initGetMyVehicles();
            (await instance<GetMyVehiclesUsecase>().execute(
                    GetMyVehiclesUsecaseInput(
                        page: state.meta!.currentPage + 1)))
                .fold((failure) {
              if (!isDisposed) {
                emit(state.copyWith(
                    fetchMoreVehiclesStatus: Status.failure,
                    fetchMoreVehiclesErrorMessage: failure.message));
              }
            }, (data) {
              if (!isDisposed) {
                emit(state.copyWith(
                  fetchMoreVehiclesStatus: Status.success,
                  myVehicles: [...state.myVehicles!, ...data.vehicles!],
                  meta: data.meta,
                ));
              }
            });
          }
        }
      }
    });
  }

  fetchHiddenVehicles() async {
    emit(state.copyWith(fetchMyHiddenVehiclesStatus: Status.loading));
    initGetMyVehicles();
    (await instance<GetMyVehiclesUsecase>()
            .execute(GetMyVehiclesUsecaseInput(isHidden: true)))
        .fold((failure) {
      if (!isDisposed) {
        emit(state.copyWith(
            fetchMyHiddenVehiclesStatus: Status.failure,
            fetchMyVehiclesErrorMessage: failure.message));
      }
    }, (data) {
      if (!isDisposed) {
        emit(state.copyWith(
          fetchMyHiddenVehiclesStatus: Status.success,
          myHiddenVehicles: data.vehicles,
          hiddenMeta: data.meta,
        ));
      }
    });

    hiddenVehiclesScrollController.addListener(() async {
      if (hiddenVehiclesScrollController.position.maxScrollExtent ==
              hiddenVehiclesScrollController.position.pixels &&
          !state.fetchMoreHiddenVehiclesStatus.isLoading) {
        if (state.hiddenMeta != null &&
            state.hiddenMeta!.currentPage < state.hiddenMeta!.lastPage) {
          if (!isDisposed) {
            emit(state.copyWith(fetchMoreHiddenVehiclesStatus: Status.loading));
            initGetMyVehicles();
            (await instance<GetMyVehiclesUsecase>()
                    .execute(GetMyVehiclesUsecaseInput(
              page: state.hiddenMeta!.currentPage + 1,
              isHidden: true,
            )))
                .fold((failure) {
              if (!isDisposed) {
                emit(state.copyWith(
                    fetchMoreHiddenVehiclesStatus: Status.failure,
                    fetchMoreHiddenVehiclesErrorMessage: failure.message));
              }
            }, (data) {
              if (!isDisposed) {
                emit(state.copyWith(
                  fetchMoreHiddenVehiclesStatus: Status.success,
                  myHiddenVehicles: [
                    ...state.myHiddenVehicles!,
                    ...data.vehicles!
                  ],
                  hiddenMeta: data.meta,
                ));
              }
            });
          }
        }
      }
    });
  }

  @override
  Future<void> close() {
    isDisposed = true;
    return super.close();
  }
}
