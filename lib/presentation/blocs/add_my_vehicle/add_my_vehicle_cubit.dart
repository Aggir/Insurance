import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/data_classes/add_vehicle_form_data.dart';
import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/entities/color.dart';
import 'package:insurance_app/domain/entities/vehicle.dart';
import 'package:insurance_app/domain/entities/vehicle_brand.dart';
import 'package:insurance_app/domain/usecases/add_vehicle_usecase.dart';
import 'package:insurance_app/domain/usecases/get_add_vehicle_form_data_usecase.dart';
import 'package:insurance_app/domain/usecases/get_cities_usecase.dart';
import 'package:insurance_app/domain/usecases/get_colors_usecase.dart';
import 'package:insurance_app/domain/usecases/get_vehicle_models_usecase.dart';

import '../../../app/constants.dart';
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
  final TextEditingController vehicleEngineNumberController =
      TextEditingController();
  final TextEditingController vehicleChassisNumberController =
      TextEditingController();

  final GlobalKey<FormState> vehiclePictureForm = GlobalKey<FormState>();
  final TextEditingController vehicleLicensePlateNumberController =
      TextEditingController();
  final TextEditingController vehicleAliasController = TextEditingController();

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

  setVehicleBrand(VehicleBrandEntity brand) async {
    emit(state.copyWith(
        getAddVehicleFormDataStatus: Status.loading,
        selectedVehicleBrand: brand));
    initGetVehicleModels();
    (await instance<GetVehicleModelsUsecase>().execute(brand.id)).fold(
      (failure) {
        emit(state.copyWith(
          getAddVehicleFormDataStatus: Status.failure,
          getAddVehicleFormDataErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          getAddVehicleFormDataStatus: Status.success,
          addVehicleFormData: state.addVehicleFormData
              ?.copyWith(vehicleModels: data.vehicleModels),
        ));
      },
    );
  }

  addVehicle() async {
    emit(state.copyWith(
      addVehicleStatus: Status.loading,
    ));
    initAddVehicle();
    (await instance<AddVehicleUsecase>().execute(AddVehicleUsecaseInput(
            ownerFirstName: firstNameController.text,
            alias: vehicleAliasController.text,
            ownerFatherName: middleNameController.text,
            ownerLastName: lastNameController.text,
            ownerPhoneNumber: phoneNumberController.text,
            ownerLocation: state.selectedOwnerCityId!,
            typeId: state.selectedVehicleTypeId!,
            brandId: state.selectedVehicleBrand!.id,
            modelId: state.selectedVehicleModelId!,
            countryId: state.selectedVehicleCountryId!,
            makingYear: state.selectedVehicleYearId!,
            horsePower: state.selectedVehicleHorsePower!.toString(),
            engineNumber: vehicleEngineNumberController.text,
            chassisNumber: vehicleChassisNumberController.text,
            colorId: state.selectedVehicleColorId!,
            maxPassengers: state.selectedVehicleSeats!.toString(),
            pictureFile: state.vehiclePictureFile!,
            licensePlateNumber: vehicleLicensePlateNumberController.text,
            cityId: state.selectedVehicleCityId!,
            ownership: state.selectedVehicleOwnershipTypeId!)))
        .fold(
      (failure) {
        emit(state.copyWith(
          addVehicleStatus: Status.failure,
          addVehicleErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          addVehicleStatus: Status.success,
        ));
      },
    );
  }

  setOwnerCity(int cityId) {
    emit(state.copyWith(selectedOwnerCityId: cityId));
  }

  setVehicleType(int vehicleTypeId) {
    emit(state.copyWith(selectedVehicleTypeId: vehicleTypeId));
  }

  setVehicleModel(int vehicleModelId) {
    emit(state.copyWith(selectedVehicleModelId: vehicleModelId));
  }

  setVehicleCountry(int vehicleCountryId) {
    emit(state.copyWith(selectedVehicleCountryId: vehicleCountryId));
  }

  setVehicleYear(int vehicleYearId) {
    emit(state.copyWith(selectedVehicleYearId: vehicleYearId));
  }

  setVehicleHorsePower(int vehicleHorsePower) {
    emit(state.copyWith(selectedVehicleHorsePower: vehicleHorsePower));
  }

  setVehicleColorId(int vehicleColorId) {
    emit(state.copyWith(selectedVehicleColorId: vehicleColorId));
  }

  setVehicleSeats(int vehicleSeats) {
    emit(state.copyWith(selectedVehicleSeats: vehicleSeats));
  }

  setVehicleCityId(int vehicleCityId) {
    emit(state.copyWith(selectedVehicleCityId: vehicleCityId));
  }

  setVehicleOwnershipTypeId(int vehicleUsageId) {
    emit(state.copyWith(selectedVehicleOwnershipTypeId: vehicleUsageId));
  }

  uploadVehiclePicture() async {
    emit(state.copyWith(vehiclePictureStatus: Status.loading));
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: Constants.allowedPictureExtensions,
    );
    if (result != null) {
      final PlatformFile firstFile = result.files.first;
      emit(state.copyWith(
        vehiclePictureFileName: firstFile.name,
        vehiclePictureStatus: Status.success,
        vehiclePictureFile: File(firstFile.path!),
      ));
    } else {
      emit(state.copyWith(vehiclePictureStatus: Status.initial));
    }
    emit(state.copyWith(vehiclePictureStatus: Status.success));
  }

  removeVehiclePicture() {
    emit(state.copyWith(
        vehiclePictureStatus: Status.initial, removeVehiclePicture: true));
  }

  getCities() async {
    emit(state.copyWith(getCitiesStatus: Status.loading));
    initGetCities();
    (await instance<GetCitiesUsecase>().execute(null)).fold(
      (failure) {
        emit(state.copyWith(
          getCitiesStatus: Status.failure,
          getCitiesErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          getCitiesStatus: Status.success,
          cities: data,
        ));
      },
    );
  }

  getColors() async {
    emit(state.copyWith(getColorsStatus: Status.loading));
    initGetColors();
    (await instance<GetColorsUsecase>().execute(null)).fold(
      (failure) {
        emit(state.copyWith(
          getColorsStatus: Status.failure,
          getColorsErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          getColorsStatus: Status.success,
          colors: data,
        ));
      },
    );
  }

  getAddVehicleFormData() async {
    emit(state.copyWith(getAddVehicleFormDataStatus: Status.loading));
    initGetAddVehicleFormData();
    (await instance<GetAddVehicleFormDataUsecase>().execute(null)).fold(
      (failure) {
        emit(state.copyWith(
          getAddVehicleFormDataStatus: Status.failure,
          getAddVehicleFormDataErrorMessage: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          getAddVehicleFormDataStatus: Status.success,
          addVehicleFormData: data,
        ));
      },
    );
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
