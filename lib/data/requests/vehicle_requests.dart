import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:insurance_app/app/extensions.dart';
import 'package:insurance_app/data/requests/base_request.dart';

class AddVehicleRequest implements BaseRequest {
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
  final String? horsePower;
  final String engineNumber;
  final String chassisNumber;
  // final int? colorId;
  final String colorName;
  final String? maxPassengers;
  final String? weight;
  final bool? withAttachment;
  final File vehiclePicture;
  final File vehicleBookletPicture;
  final String? alias;
  final String licensePlateNumber;
  final int cityId;
  AddVehicleRequest({
    required this.ownerFirstName,
    required this.ownerFatherName,
    required this.ownerLastName,
    required this.ownerPhoneNumber,
    required this.ownerLocation,
    required this.ownerPhoneCode,
    required this.typeId,
    required this.brandId,
    required this.modelId,
    required this.countryId,
    required this.makingYear,
    required this.horsePower,
    required this.weight,
    required this.withAttachment,
    required this.engineNumber,
    required this.chassisNumber,
    // required this.colorId,
    required this.colorName,
    required this.maxPassengers,
    required this.vehiclePicture,
    required this.vehicleBookletPicture,
    required this.alias,
    required this.licensePlateNumber,
    required this.cityId,
  });

  Future<Map<String, dynamic>> toMap() async {
    return {
      'owner_first_name': ownerFirstName,
      'owner_father_name': ownerFatherName,
      'owner_last_name': ownerLastName,
      'owner_phone_number':
          (ownerPhoneCode + ownerPhoneNumber).replaceFirst('+', ''),
      'owner_phone_code': ownerPhoneCode,
      'owner_city_id': ownerLocation,
      'vehicle_type_id': typeId,
      'vehicle_brand_id': brandId,
      'vehicle_model_id': modelId,
      'vehicle_country_id': countryId,
      'making_year': makingYear,
      'horse_power': horsePower,
      'with_attachment': withAttachment?.asString ?? false.asString,
      'weight': weight,
      'engine_number': engineNumber,
      'chassisNumber': chassisNumber,
      // 'color_id': colorId,
      'color_name': colorName,
      'max_passengers': maxPassengers,
      'photo': await MultipartFile.fromFile(vehiclePicture.path),
      'booklet_photo': await MultipartFile.fromFile(vehicleBookletPicture.path),
      'alias': alias,
      'license_plate': licensePlateNumber,
      'city_id': cityId,
    };
  }

  String toJson() => json.encode(toMap());
}
