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

  final ScrollController scrollController = ScrollController();
  bool isDisposed = false;

  init() async {
    emit(state.copyWith(fetchMyVehiclesStatus: Status.loading));
    initGetMyVehicles();
    (await instance<GetMyVehiclesUsecase>().execute(null)).fold((failure) {
      if (!isDisposed) {
        emit(state.copyWith(
            fetchMyVehiclesStatus: Status.failure,
            fetchMyVehiclesErrorMessage: failure.message));
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

    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          !state.fetchMoreVehiclesStatus.isLoading) {
        if (state.meta != null &&
            state.meta!.currentPage < state.meta!.lastPage) {
          if (!isDisposed) {
            emit(state.copyWith(fetchMoreVehiclesStatus: Status.loading));
            initGetMyVehicles();
            (await instance<GetMyVehiclesUsecase>()
                    .execute(state.meta!.currentPage + 1))
                .fold((failure) {
              emit(state.copyWith(
                  fetchMoreVehiclesStatus: Status.failure,
                  fetchMoreVehiclesErrorMessage: failure.message));
            }, (data) {
              emit(state.copyWith(
                fetchMoreVehiclesStatus: Status.success,
                myVehicles: [...state.myVehicles!, ...data.vehicles!],
                meta: data.meta,
              ));
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
