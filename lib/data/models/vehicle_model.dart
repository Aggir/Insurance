import 'package:insurance_app/data/models/vehicle_brand_model.dart';
import 'package:insurance_app/data/models/vehicle_country_model.dart';
import 'package:insurance_app/data/models/vehicle_model_model.dart';
import 'package:insurance_app/data/models/vehicle_ownership_type_model.dart';
import 'package:insurance_app/data/models/vehicle_type_model.dart';

import 'city_model.dart';
import 'color_model.dart';

class VehicleModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final int? makingYear;
  final String? horsePower;
  final String? engineNumber;
  final int? maxPassengers;
  final String? photo;
  final String? licensePlate;
  final String? ownerFirstName;
  final String? ownerFatherName;
  final String? ownerLastName;
  final String? ownerPhoneNumber;
  final String? alias;
  final CityModel? ownerCity;
  final bool? isHidden;
  final VehicleBrandModel? brand;
  final VehicleModelModel? model;
  final VehicleCountryModel? country;
  final VehicleOwnershipTypeModel? ownershipType;
  final CityModel? city;
  final ColorModel? color;
  final VehicleTypeModel? type;

  const VehicleModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.makingYear,
    this.horsePower,
    this.engineNumber,
    this.maxPassengers,
    this.photo,
    this.licensePlate,
    this.alias,
    this.ownerFirstName,
    this.ownerFatherName,
    this.ownerLastName,
    this.ownerPhoneNumber,
    this.ownerCity,
    this.brand,
    this.model,
    this.isHidden,
    this.country,
    this.ownershipType,
    this.city,
    this.color,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'making_year': makingYear,
      'horse_power': horsePower,
      'engine_number': engineNumber,
      'max_passengers': maxPassengers,
      'photo': photo,
      'license_plate': licensePlate,
      'owner_first_name': ownerFirstName,
      'owner_father_name': ownerFatherName,
      'owner_last_name': ownerLastName,
      'owner_phone_number': ownerPhoneNumber,
      'is_hidden': isHidden,
      'alias': alias,
      'owner_city': ownerCity?.toMap(),
      'brand': brand?.toMap(),
      'model': model?.toMap(),
      'country': country?.toMap(),
      'ownership': ownershipType?.toMap(),
      'city': city?.toMap(),
      'color': color?.toMap(),
      'type': type?.toMap(),
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['id']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      makingYear: map['making_year']?.toInt(),
      horsePower: map['horse_power'],
      engineNumber: map['engine_number'],
      maxPassengers: map['max_passengers']?.toInt(),
      photo: map['photo'],
      licensePlate: map['license_plate'],
      ownerFirstName: map['owner_first_name'],
      ownerFatherName: map['owner_father_name'],
      ownerLastName: map['owner_last_name'],
      ownerPhoneNumber: map['owner_phone_number'],
      isHidden: map['is_hidden'],
      alias: map['alias'],
      brand:
          map['brand'] != null ? VehicleBrandModel.fromMap(map['brand']) : null,
      model:
          map['model'] != null ? VehicleModelModel.fromMap(map['model']) : null,
      ownerCity: map['owner_city'] != null
          ? CityModel.fromMap(map['owner_city'])
          : null,
      country: map['country'] != null
          ? VehicleCountryModel.fromMap(map['country'])
          : null,
      ownershipType: map['ownership'] != null
          ? VehicleOwnershipTypeModel.fromMap(map['ownership'])
          : null,
      city: map['city'] != null ? CityModel.fromMap(map['city']) : null,
      color: map['color'] != null ? ColorModel.fromMap(map['color']) : null,
      type: map['type'] != null ? VehicleTypeModel.fromMap(map['type']) : null,
    );
  }
}
