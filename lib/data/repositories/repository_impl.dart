import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/mapper/branch_mapper.dart';
import 'package:insurance_app/data/mapper/city_mapper.dart';
import 'package:insurance_app/data/mapper/color_mapper.dart';
import 'package:insurance_app/data/mapper/company_mapper.dart';
import 'package:insurance_app/data/mapper/insurance_type_mapper.dart';
import 'package:insurance_app/data/mapper/meta_mapper.dart';
import 'package:insurance_app/data/mapper/notification_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_brand_mapper.dart';
import 'package:insurance_app/data/responses/base_response.dart';
import 'package:insurance_app/domain/data_classes/companies_page.dart';
import 'package:insurance_app/domain/data_classes/company_prices_form_data.dart';
import 'package:insurance_app/domain/entities/branch.dart';
import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/entities/color.dart';
import 'package:insurance_app/domain/entities/notification.dart';
import 'package:insurance_app/domain/repositories/repository.dart';

import '../../app/app_strings.dart';
import '../datasources/remote_datasource.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  RepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, List<CityEntity>>> getCities() async {
    final response = await _remoteDataSource.getCities();
    if (response.cities == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.cities?.map((e) => e.toDomain()).toList() ?? []);
    }
  }

  @override
  Future<Either<Failure, List<ColorEntity>>> getColors() async {
    final response = await _remoteDataSource.getColors();
    if (response.colors == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.colors?.map((e) => e.toDomain()).toList() ?? []);
    }
  }

  @override
  Future<Either<Failure, CompaniesPage>> getCompanies(int? page) async {
    final response = await _remoteDataSource.getCompanies(page);
    if (response.companies == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(
        CompaniesPage(
          companies:
              response.companies?.map((e) => e.toDomain()).toList() ?? [],
          meta: response.meta.toDomain(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BranchEntity>>> getCompanyBranches(
      int companyId) async {
    final response = await _remoteDataSource.getCompanyBranches(companyId);
    if (response.branches == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(
        response.branches?.map((e) => e.toDomain()).toList() ?? [],
      );
    }
  }

  @override
  Future<Either<Failure, CompanyPricesFormData>>
      getCompanyPricesFormData() async {
    final vehicleBrandsResponse = await _remoteDataSource.getVehicleBrands();
    try {
      if (vehicleBrandsResponse.vehicleBrands == null) {
        throw vehicleBrandsResponse;
      }
      final insuranceTypesResponse =
          await _remoteDataSource.getInsuranceTypes();
      if (insuranceTypesResponse.insuranceTypes == null) {
        throw insuranceTypesResponse;
      }
      return Right(CompanyPricesFormData(
        vehicleBrands: vehicleBrandsResponse.vehicleBrands
                ?.map((e) => e.toDomain())
                .toList() ??
            [],
        insuranceTypes: insuranceTypesResponse.insuranceTypes
                ?.map((e) => e.toDomain())
                .toList() ??
            [],
      ));
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
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    final response = await _remoteDataSource.getNotifications();
    if (response.notifications == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      // Remove Take Function
      return Right(
          response.notifications?.map((e) => e.toDomain()).toList() ?? []);
    }
  }

  @override
  Future<Either<Failure, void>> toggleNotificationsIsSeen() async {
    final response = await _remoteDataSource.toggleNotificationsIsSeen();
    if (response.message != null) {
      return Left(
        Failure(
          response.code ?? 0,
          response.message ?? AppStrings.genericError.tr(),
        ),
      );
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> toggleNotificationIsRead(int id) async {
    final response = await _remoteDataSource.toggleNotificationIsRead(id);
    if (response.message != null) {
      return Left(
        Failure(
          response.code ?? 0,
          response.message ?? AppStrings.genericError.tr(),
        ),
      );
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, int>> countUnseenNotifications() async {
    final response = await _remoteDataSource.countUnseenNotifications();
    if (response.message != null) {
      return Left(
        Failure(
          response.code ?? 0,
          response.message ?? AppStrings.genericError.tr(),
        ),
      );
    } else {
      return Right(int.parse(response.data));
    }
  }
}
