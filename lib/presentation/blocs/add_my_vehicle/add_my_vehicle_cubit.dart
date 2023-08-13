import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/vehicle.dart';
part 'add_my_vehicle_state.dart';

class AddMyVehicleCubit extends Cubit<AddMyVehicleState> {
  AddMyVehicleCubit() : super(const AddMyVehicleState());

  final GlobalKey<FormState> userInfoForm = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> vehicleDetailsOneForm = GlobalKey<FormState>();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController vehicleBrandController = TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  final TextEditingController vehicleCountryController =
      TextEditingController();
  final TextEditingController vehicleYearController = TextEditingController();

  final GlobalKey<FormState> vehicleDetailsTwoForm = GlobalKey<FormState>();

  final GlobalKey<FormState> vehiclePictureForm = GlobalKey<FormState>();

  bool isUserInfoValid() {
    return userInfoForm.currentState?.validate() ?? false;
  }

  bool isVehicleDetailsFormOneValid() {
    return vehicleDetailsOneForm.currentState?.validate() ?? false;
  }

  bool isVehicleDetailsFormTwoValid() {
    return vehicleDetailsTwoForm.currentState?.validate() ?? false;
  }

  bool isVehiclePictureFormValid() {
    return vehiclePictureForm.currentState?.validate() ?? false;
  }

  setCarBrand(Map<String, String> brand) {
    emit(state.copyWith(carBrand: brand));
  }

  toggleIsPublicUse() {
    emit(state.copyWith(isPublicUse: !state.isPublicUse));
  }

  uploadVehiclePicture() async {
    emit(state.copyWith(vehiclePictureStatus: Status.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(vehiclePictureStatus: Status.success));
  }

  removeVehiclePicture() {
    emit(state.copyWith(vehiclePictureStatus: Status.initial));
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    return super.close();
  }
}
