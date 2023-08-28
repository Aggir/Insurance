import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:insurance_app/data/requests/vehicle_requests.dart';

import 'package:insurance_app/domain/repositories/vehicle_repository.dart';

import '../../app/failure.dart';

import 'base_usecase.dart';

class AddVehicleUsecase implements BaseUsecase<AddVehicleUsecaseInput, void> {
  final VehicleRepository _repository;
  const AddVehicleUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(AddVehicleUsecaseInput input) async {
    return await _repository.addVehicle(AddVehicleRequest(
      ownerFirstName: input.ownerFirstName,
      ownerFatherName: input.ownerFatherName,
      ownerLastName: input.ownerLastName,
      ownerPhoneNumber: input.ownerPhoneNumber,
      ownerPhoneCode: input.ownerPhoneCode,
      ownerLocation: input.ownerLocation,
      typeId: input.typeId,
      brandId: input.brandId,
      modelId: input.modelId,
      countryId: input.countryId,
      makingYear: input.makingYear,
      horsePower: input.horsePower,
      engineNumber: input.engineNumber,
      chassisNumber: input.chassisNumber,
      colorId: input.colorId,
      maxPassengers: input.maxPassengers,
      pictureFile: input.pictureFile,
      alias: input.alias,
      licensePlateNumber: input.licensePlateNumber,
      cityId: input.cityId,
      ownership: input.ownership,
    ));
  }
}

class AddVehicleUsecaseInput {
  final String ownerFirstName;
  final String ownerFatherName;
  final String ownerLastName;
  final String ownerPhoneNumber;
  final String ownerPhoneCode;
  final int ownerLocation;
  final int typeId;
  final int brandId;
  final int modelId;
  final int countryId;
  final int makingYear;
  final String horsePower;
  final String engineNumber;
  final String chassisNumber;
  final int colorId;
  final String maxPassengers;
  final File pictureFile;
  final String? alias;
  final String licensePlateNumber;
  final int cityId;
  final int ownership;
  AddVehicleUsecaseInput({
    required this.ownerFirstName,
    required this.ownerFatherName,
    required this.ownerLastName,
    required this.ownerPhoneNumber,
    required this.ownerPhoneCode,
    required this.ownerLocation,
    required this.typeId,
    required this.brandId,
    required this.modelId,
    required this.countryId,
    required this.makingYear,
    required this.horsePower,
    required this.engineNumber,
    required this.chassisNumber,
    required this.colorId,
    required this.maxPassengers,
    required this.pictureFile,
    this.alias,
    required this.licensePlateNumber,
    required this.cityId,
    required this.ownership,
  });
}
