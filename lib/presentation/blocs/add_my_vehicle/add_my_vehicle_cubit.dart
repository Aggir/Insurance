import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/domain/entities/add_my_vehicle_user_info.dart';
part 'add_my_vehicle_state.dart';

class AddMyVehicleCubit extends Cubit<AddMyVehicleState> {
  AddMyVehicleCubit() : super(const AddMyVehicleState());
}
