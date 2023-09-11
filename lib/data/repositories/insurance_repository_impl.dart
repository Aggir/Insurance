import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/mapper/company_mapper.dart';
import 'package:insurance_app/data/mapper/company_price_mapper.dart';
import 'package:insurance_app/data/mapper/insurance_installments_mapper.dart';
import 'package:insurance_app/data/mapper/insurance_mapper.dart';
import 'package:insurance_app/data/mapper/insurance_type_mapper.dart';
import 'package:insurance_app/data/mapper/meta_mapper.dart';
import 'package:insurance_app/data/mapper/vehicle_mapper.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/data_classes/insurances_page.dart';
import 'package:insurance_app/domain/data_classes/issue_insurance_form_data.dart';
import 'package:insurance_app/domain/entities/company_price.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/insurance_installments.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';

import '../../app/app_strings.dart';
import '../../app/constants.dart';
import '../datasources/remote_datasource.dart';
import '../responses/base_response.dart';

class InsuranceRepositoryImpl implements InsuranceRepository {
  final RemoteDataSource _remoteDataSource;
  InsuranceRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, IssueInsuranceFormData>> getInsuranceFormData() async {
    try {
      // Todo: add pagination
      final companiesResponse = await _remoteDataSource.getCompanies(null);
      if (companiesResponse.companies == null) {
        throw companiesResponse;
      }
      final insuranceTypesResponse =
          await _remoteDataSource.getInsuranceTypes();
      if (insuranceTypesResponse.insuranceTypes == null) {
        throw insuranceTypesResponse;
      }
      // Todo: add pagination
      final vehiclesResponse = await _remoteDataSource.getMyVehicles();
      if (vehiclesResponse.vehicles == null) {
        throw vehiclesResponse;
      }
      return Right(
        IssueInsuranceFormData(
          companies:
              companiesResponse.companies?.map((e) => e.toDomain()).toList() ??
                  [],
          insuranceTypes: insuranceTypesResponse.insuranceTypes
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
          vehicles:
              vehiclesResponse.vehicles?.map((e) => e.toDomain()).toList() ??
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
  Future<Either<Failure, String>> calculateInsurancePriceByVehicle(
      CalculateInsurancePriceByVehicleRequest request) async {
    final response =
        await _remoteDataSource.calculateInsurancePriceByVehicle(request);

    if (response.data == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(
        response.data,
      );
    }
  }

  @override
  Future<Either<Failure, InsuranceEntity>> issueInsurance(
      IssueInsuranceRequest request) async {
    final response = await _remoteDataSource.issueInsurance(request);

    if (response.message != null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.insurance.toDomain());
    }
  }

  @override
  Future<Either<Failure, InsurancesPage>> getMyInsurances({int? page}) async {
    final response = await _remoteDataSource.getMyInsurances(page: page);
    if (response.message != null) {
      return Left(Failure(
        response.code ?? Constants.zero,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(
        InsurancesPage(
          insurances: response.insurances
              ?.map((insurance) => insurance.toDomain())
              .toList(),
          meta: response.meta.toDomain(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> pay(int insuranceId) async {
    final response = await _remoteDataSource.pay(insuranceId);
    if (response.message != null) {
      return Left(Failure(response.code ?? 0,
          response.message ?? AppStrings.genericError.tr()));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, List<InsuranceTypeEntity>>> getInsuranceTypes() async {
    final response = await _remoteDataSource.getInsuranceTypes();
    if (response.message != null) {
      return Left(Failure(response.code ?? 0,
          response.message ?? AppStrings.genericError.tr()));
    } else {
      return Right(
        response.insuranceTypes?.map((e) => e.toDomain()).toList() ?? [],
      );
    }
  }

  @override
  Future<Either<Failure, List<CompanyPriceEntity>>> getCompaniesPrices(
      CompaniesPricesRequest request) async {
    final response = await _remoteDataSource.getCompaniesPrices(request);
    if (response.message != null) {
      return Left(Failure(response.code ?? 0,
          response.message ?? AppStrings.genericError.tr()));
    } else {
      return Right(
        response.companiesPrices?.map((e) => e.toDomain()).toList() ?? [],
      );
    }
  }

  @override
  Future<Either<Failure, String>> calculateInsurancePrice(
      CalculateInsurancePriceRequest request) async {
    final response = await _remoteDataSource.calculateInsurancePrice(request);

    if (response.data == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(
        response.data,
      );
    }
  }

  @override
  Future<Either<Failure, InsuranceInstallmentsEntity>> getInsuranceInstallments(
      GetInsuranceInstallmentsRequest request) async {
    final response = await _remoteDataSource.getInsuranceInstallments(request);

    if (response.message != null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(
        response.installmentModel.toDomain(),
      );
    }
  }
}
