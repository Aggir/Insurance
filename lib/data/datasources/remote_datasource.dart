import 'package:insurance_app/data/requests/alarm_requests.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/data/requests/vehicle_requests.dart';
import 'package:insurance_app/data/responses/alarm_types_response.dart';
import 'package:insurance_app/data/responses/alarms_response.dart';
import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/branches_response.dart';
import 'package:insurance_app/data/responses/cities_response.dart';
import 'package:insurance_app/data/responses/companies_prices_response.dart';
import 'package:insurance_app/data/responses/installments_response.dart';
import 'package:insurance_app/data/responses/insurance_types_response.dart';
import 'package:insurance_app/data/responses/insurances_response.dart';
import 'package:insurance_app/data/responses/issue_insurance_response.dart';
import 'package:insurance_app/data/responses/notifications_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';
import 'package:insurance_app/data/responses/colors_response.dart';
import 'package:insurance_app/data/responses/vehicle_brands_response.dart';
import 'package:insurance_app/data/responses/vehicle_countries_response.dart';
import 'package:insurance_app/data/responses/vehicle_models_response.dart';
import 'package:insurance_app/data/responses/vehicle_ownership_types_response.dart';
import 'package:insurance_app/data/responses/vehicle_types_response.dart';

import '../requests/user_requests.dart';
import '../responses/companies_response.dart';
import '../responses/vehicles_response.dart';

abstract class RemoteDataSource {
  Future<UserResponse> signIn(SignInRequest request);

  Future<BasicResponse> signOut();

  Future<UserResponse> signUp(SignUpRequest request);

  Future<UserResponse> isLoggedIn();

  Future<BasicResponse> checkUserInfo(CheckUserInfoRequest request);

  Future<BasicResponse> checkProofId(String proofId);

  Future<BasicResponse> checkNationalId(String nationalId);

  Future<UserResponse> editProfile(EditProfileRequest request);

  Future<BasicResponse> changePassword(ChangePasswordRequest request);

  Future<CitiesResponse> getCities();

  Future<ColorsResponse> getColors();

  Future<VehicleBrandsResponse> getVehicleBrands();

  Future<VehicleCountriesResponse> getVehicleCountries();

  Future<VehicleOwnershipTypesResponse> getVehicleOwnershipTypes();

  Future<VehicleTypesResponse> getVehicleTypes();

  Future<VehicleModelsResponse> getVehicleModels(int vehicleBrandId);

  Future<BasicResponse> addVehicle(AddVehicleRequest request);

  Future<VehiclesResponse> getMyVehicles({int? page, bool isHidden = false});

  Future<BasicResponse> toggleIsVehicleHidden(int vehicleId);

  Future<CompaniesResponse> getCompanies(int? page);

  Future<BranchesResponse> getCompanyBranches(int? companyId);

  Future<InsuranceTypesResponse> getInsuranceTypes();

  Future<BasicResponse> calculateInsurancePriceByVehicle(
      CalculateInsurancePriceByVehicleRequest request);

  Future<BasicResponse> calculateInsurancePrice(
      CalculateInsurancePriceRequest request);

  Future<IssueInsuranceResponse> issueInsurance(IssueInsuranceRequest request);

  Future<BasicResponse> deactivate();

  Future<BasicResponse> forgotPassword(String email);

  Future<BasicResponse> verifyForgotPasswordOtp(
      VerifyOtpForgotPasswordRequest request);

  Future<BasicResponse> resetPassword(ResetPasswordRequest request);

  Future<InsurancesResponse> getMyInsurances({int? page});

  Future<BasicResponse> pay(int insuranceId);

  Future<AlarmTypesResponse> getAlarmTypes();

  Future<BasicResponse> addAlarm(AddAlarmRequest request);

  Future<AlarmsResponse> getMyAlarms({int? page});

  Future<NotificationsResponse> getNotifications();

  Future<BasicResponse> toggleNotificationsIsSeen();

  Future<BasicResponse> toggleNotificationIsRead(int id);

  Future<BasicResponse> countUnseenNotifications();

  Future<CompaniesPricesResponse> getCompaniesPrices(
      CompaniesPricesRequest request);

  Future<BasicResponse> sendVerifyPhoneOtp(String phone);

  Future<BasicResponse> countCompanies();

  Future<InstallmentsResponse> getInsuranceInstallments(
      GetInsuranceInstallmentsRequest request);
}
