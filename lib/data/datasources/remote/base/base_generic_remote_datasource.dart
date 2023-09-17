import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/data/responses/index.dart';

abstract class BaseGenericRemoteDatasource {
  Future<CitiesResponse> getCities();

  Future<ColorsResponse> getColors();

  Future<CompaniesResponse> getCompanies(int? page);

  Future<BranchesResponse> getCompanyBranches(int? companyId);

  Future<NotificationsResponse> getNotifications();

  Future<BasicResponse> toggleNotificationsIsSeen();

  Future<BasicResponse> toggleNotificationIsRead(int id);

  Future<BasicResponse> countUnseenNotifications();

  Future<CompaniesPricesResponse> getCompaniesPrices(
      CompaniesPricesRequest request);

  Future<BasicResponse> countCompanies();
}
