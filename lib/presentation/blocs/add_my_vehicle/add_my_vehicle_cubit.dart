import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/domain/entities/add_my_vehicle_user_info.dart';
part 'add_my_vehicle_state.dart';

class AddMyVehicleCubit extends Cubit<AddMyVehicleState> {
  AddMyVehicleCubit() : super(const AddMyVehicleState());

  final GlobalKey<FormState> userInfoForm = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> vehicleDetailsForm = GlobalKey<FormState>();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController vehicleBrandController = TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  final TextEditingController vehicleCountryController =
      TextEditingController();
  final TextEditingController vehicleYearController = TextEditingController();

  bool isUserInfoValid() {
    return userInfoForm.currentState?.validate() ?? false;
  }

  bool isVehicleDetailsFormValid() {
    return vehicleDetailsForm.currentState?.validate() ?? false;
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
