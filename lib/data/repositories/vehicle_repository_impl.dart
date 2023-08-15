import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/mapper/vehicle_brand_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_country_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_model_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_ownership_type_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_type_mapper.dart';
import 'package:insurance_app/data/requests/vehicle_requests.dart';
import 'package:insurance_app/data/responses/base_response.dart';
import 'package:insurance_app/domain/data_classes/add_vehicle_form_data.dart';
import 'package:insurance_app/domain/repositories/vehicle_repository.dart';

import '../../app/app_strings.dart';
import '../datasources/remote_datasource.dart';

class VehicleRepositoryImpl extends VehicleRepository {
  final RemoteDataSource _remoteDataSource;
  VehicleRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AddVehicleFormData>> getVehicleFormOneData() async {
    try {
      final vehicleTypesResponse = await _remoteDataSource.getVehicleTypes();
      if (vehicleTypesResponse.vehicleTypes == null) {
        throw vehicleTypesResponse;
      }
      final vehicleBrandsResponse = await _remoteDataSource.getVehicleBrands();
      if (vehicleBrandsResponse.vehicleBrands == null) {
        throw vehicleBrandsResponse;
      }
      final vehicleModelsResponse = await _remoteDataSource
          .getVehicleModels(vehicleBrandsResponse.vehicleBrands!.first.id);
      if (vehicleModelsResponse.vehicleModels == null) {
        throw vehicleModelsResponse;
      }
      final vehicleCountriesResponse =
          await _remoteDataSource.getVehicleCountries();
      if (vehicleCountriesResponse.vehicleCountries == null) {
        throw vehicleCountriesResponse;
      }
      final vehicleOwnershipTypesResponse =
          await _remoteDataSource.getVehicleOwnershipTypes();
      if (vehicleOwnershipTypesResponse.vehicleOwnershipTypes == null) {
        throw vehicleOwnershipTypesResponse;
      }
      return Right(
        AddVehicleFormData(
          vehicleTypes: vehicleTypesResponse.vehicleTypes
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
          vehicleBrands: vehicleBrandsResponse.vehicleBrands
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
          vehicleModels: vehicleModelsResponse.vehicleModels
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
          vehicleCountries: vehicleCountriesResponse.vehicleCountries
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
          vehicleOwnershipTypes: vehicleOwnershipTypesResponse
                  .vehicleOwnershipTypes
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
        ),
      );
    } on BaseResponse catch (response) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } catch (error) {
      return Left(Failure(
        Constants.zero,
        AppStrings.genericError.tr(),
      ));
    }
  }

  @override
  Future<Either<Failure, AddVehicleFormData>> getVehicleModels(
      int vehicleBrandId) async {
    final response = await _remoteDataSource.getVehicleModels(vehicleBrandId);
    if (response.vehicleModels == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(
        AddVehicleFormData(
          vehicleModels:
              response.vehicleModels?.map((e) => e.toDomain()).toList() ?? [],
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addVehicle(AddVehicleRequest request) async {
    final response = await _remoteDataSource.addVehicle(request);
    if (response.message != null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return const Right(null);
    }
  }
}
