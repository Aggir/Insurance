import 'package:insurance_app/data/models/city_model.dart';

class InsuranceVehicleModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final int? makingYear;
  final String? horsePower;
  final String? engineNumber;
  final String? alias;
  final int? maxPassengers;
  final String? photo;
  final String? licensePlate;
  final String? ownerFirstName;
  final String? ownerFatherName;
  final String? ownerLastName;
  final String? ownerPhoneNumber;
  final int? ownerCityId;
  final bool? isHidden;
  final int? userId;
  final int? colorId;
  final int? cityId;
  final int? vehicleBrandId;
  final int? vehicleModelId;
  final int? vehicleOwnershipTypeId;
  final int? vehicleCountryId;
  final int? vehicleUsageId;
  final int? vehicleTypeId;
  final int? insuranceId;
  final CityModel? city;

  InsuranceVehicleModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.makingYear,
    this.horsePower,
    this.engineNumber,
    this.alias,
    this.maxPassengers,
    this.photo,
    this.licensePlate,
    this.ownerFirstName,
    this.ownerFatherName,
    this.ownerLastName,
    this.ownerPhoneNumber,
    this.ownerCityId,
    this.isHidden,
    this.userId,
    this.colorId,
    this.cityId,
    this.vehicleBrandId,
    this.vehicleModelId,
    this.vehicleOwnershipTypeId,
    this.vehicleCountryId,
    this.vehicleUsageId,
    this.vehicleTypeId,
    this.insuranceId,
    this.city,
  });

  factory InsuranceVehicleModel.fromMap(Map<String, dynamic> map) {
    return InsuranceVehicleModel(
      id: map['id'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      makingYear: map['making_year'],
      horsePower: map['horse_power'],
      engineNumber: map['engine_number'],
      alias: map['alias'],
      maxPassengers: map['max_passengers'],
      photo: map['photo'],
      licensePlate: map['license_plate'],
      ownerFirstName: map['owner_first_name'],
      ownerFatherName: map['owner_father_name'],
      ownerLastName: map['owner_last_name'],
      ownerPhoneNumber: map['owner_phone_number'],
      ownerCityId: map['owner_city_id'],
      isHidden: map['is_hidden'],
      userId: map['user_id'],
      colorId: map['color_id'],
      cityId: map['city_id'],
      vehicleBrandId: map['vehicle_brand_id'],
      vehicleModelId: map['vehicle_model_id'],
      vehicleOwnershipTypeId: map['vehicle_ownership_type_id'],
      vehicleCountryId: map['vehicle_country_id'],
      vehicleUsageId: map['vehicle_usage_id'],
      vehicleTypeId: map['vehicle_type_id'],
      insuranceId: map['insurance_id'],
      city: map['city'] != null ? CityModel.fromMap(map['city']) : null,
    );
  }
}
