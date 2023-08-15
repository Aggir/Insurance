import 'package:insurance_app/data/models/vehicle_country_model.dart';
import 'package:insurance_app/data/models/vehicle_ownership_type_model.dart';

import 'city_model.dart';
import 'color_model.dart';

class VehicleModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? makingYear;
  final String? horsePower;
  final String? engineNumber;
  final int? maxPassengers;
  final String? photo;
  final String? licensePlate;
  final String? ownerFirstName;
  final String? ownerFatherName;
  final String? ownerLastName;
  final String? ownerPhoneNumber;
  final String? ownerLocation;
  final bool? isHidden;
  final VehicleCountryModel? country;
  final VehicleOwnershipTypeModel? ownershipType;
  final CityModel? city;
  final ColorModel? color;

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
    this.ownerFirstName,
    this.ownerFatherName,
    this.ownerLastName,
    this.ownerPhoneNumber,
    this.ownerLocation,
    this.isHidden,
    this.country,
    this.ownershipType,
    this.city,
    this.color,
  });
}
