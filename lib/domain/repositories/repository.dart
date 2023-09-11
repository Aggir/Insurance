import 'package:dartz/dartz.dart';
import 'package:insurance_app/domain/data_classes/companies_page.dart';
import 'package:insurance_app/domain/data_classes/company_prices_form_data.dart';
import 'package:insurance_app/domain/entities/branch.dart';
import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/entities/color.dart';
import 'package:insurance_app/domain/entities/notification.dart';

import '../../app/failure.dart';

abstract class Repository {
  Future<Either<Failure, List<CityEntity>>> getCities();

  Future<Either<Failure, List<ColorEntity>>> getColors();

  Future<Either<Failure, CompaniesPage>> getCompanies(int? page);

  Future<Either<Failure, List<BranchEntity>>> getCompanyBranches(int companyId);

  Future<Either<Failure, CompanyPricesFormData>> getCompanyPricesFormData();

  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  Future<Either<Failure, void>> toggleNotificationsIsSeen();

  Future<Either<Failure, void>> toggleNotificationIsRead(int id);

  Future<Either<Failure, int>> countUnseenNotifications();

  Future<Either<Failure, int>> countCompanies();
}
