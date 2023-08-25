import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/alarm.dart';
import 'package:insurance_app/domain/entities/meta.dart';
import 'package:insurance_app/domain/usecases/get_my_alarms_usecase.dart';

part 'my_alarms_state.dart';

class MyAlarmsCubit extends Cubit<MyAlarmsState> {
  MyAlarmsCubit() : super(const MyAlarmsState());

  final ScrollController scrollController = ScrollController();
  bool isDisposed = false;

  init() async {
    emit(state.copyWith(fetchMyAlarmsStatus: Status.loading));
    initGetMyAlarms();
    (await instance<GetMyAlarmsUsecase>().execute(null)).fold(
      (failure) {
        if (!isDisposed) {
          emit(state.copyWith(
            fetchMyAlarmsStatus: Status.failure,
            fetchMyAlarmsErrorMessage: failure.message,
          ));
        }
      },
      (data) {
        if (!isDisposed) {
          emit(state.copyWith(
            fetchMyAlarmsStatus: Status.success,
            myAlarms: data.myAlarms,
            meta: data.meta,
          ));
        }
      },
    );

    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          !state.fetchMoreAlarmsStatus.isLoading) {
        if (state.meta != null &&
            state.meta!.currentPage < state.meta!.lastPage) {
          if (!isDisposed) {
            emit(state.copyWith(fetchMoreAlarmsStatus: Status.loading));
            initGetMyVehicles();
            (await instance<GetMyAlarmsUsecase>()
                    .execute(state.meta!.currentPage + 1))
                .fold((failure) {
              if (!isDisposed) {
                emit(state.copyWith(
                    fetchMoreAlarmsStatus: Status.failure,
                    fetchMoreAlarmsErrorMessage: failure.message));
              }
            }, (data) {
              if (!isDisposed) {
                emit(state.copyWith(
                  fetchMoreAlarmsStatus: Status.success,
                  myAlarms: [...state.myAlarms!, ...data.myAlarms],
                  meta: data.meta,
                ));
              }
            });
          }
        }
      }
    });
  }
}
