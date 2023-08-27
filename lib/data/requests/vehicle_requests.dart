import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:insurance_app/data/requests/base_request.dart';

class AddVehicleRequest implements BaseRequest {
  final String ownerFirstName;
  final String ownerFatherName;
  final String ownerLastName;
  final String ownerPhoneNumber;
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
  AddVehicleRequest({
    required this.ownerFirstName,
    required this.ownerFatherName,
    required this.ownerLastName,
    required this.ownerPhoneNumber,
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

  Future<Map<String, dynamic>> toMap() async {
    return {
      'owner_first_name': ownerFirstName,
      'owner_father_name': ownerFatherName,
      'owner_last_name': ownerLastName,
      'owner_phone_number': ownerPhoneNumber,
      'owner_city_id': ownerLocation,
      'vehicle_type_id': typeId,
      'vehicle_brand_id': brandId,
      'vehicle_model_id': modelId,
      'vehicle_country_id': countryId,
      'making_year': makingYear,
      'horse_power': horsePower,
      'engine_number': engineNumber,
      'chassisNumber': chassisNumber,
      'color_id': colorId,
      'max_passengers': maxPassengers,
      'photo': await MultipartFile.fromFile(pictureFile.path),
      'alias': alias,
      'license_plate': licensePlateNumber,
      'city_id': cityId,
      'vehicle_ownership_type_id': ownership,
    };
  }

  String toJson() => json.encode(toMap());
}
