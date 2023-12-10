import 'package:insurance_app/data/datasources/index.dart';
import 'package:insurance_app/data/datasources/remote/base/index.dart';
import 'package:insurance_app/data/requests/index.dart';
import 'package:insurance_app/data/responses/index.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final BaseAlarmRemoteDatasource _alarmRemoteDatasource;
  final BaseGenericRemoteDatasource _genericRemoteDatasource;
  final BaseInsuranceRemoteDatasource _insuranceRemoteDatasource;
  final BaseUserRemoteDatasource _userRemoteDataSource;
  final BaseVehicleRemoteDatasource _vehicleRemoteDatasource;

  const RemoteDataSourceImpl(
      this._alarmRemoteDatasource,
      this._genericRemoteDatasource,
      this._insuranceRemoteDatasource,
      this._userRemoteDataSource,
      this._vehicleRemoteDatasource);

  @override
  Future<UserResponse> isLoggedIn() async {
    return await _userRemoteDataSource.isLoggedIn();
  }

  @override
  Future<UserResponse> signIn(SignInRequest request) async {
    return await _userRemoteDataSource.signIn(request);
  }

  @override
  Future<BasicResponse> signOut() async {
    return await _userRemoteDataSource.signOut();
  }

  @override
  Future<UserResponse> signUp(SignUpRequest request) async {
    return await _userRemoteDataSource.signUp(request);
  }

  @override
  Future<BasicResponse> checkUserInfo(CheckUserInfoRequest request) async {
    return await _userRemoteDataSource.checkUserInfo(request);
  }

  @override
  Future<BasicResponse> checkProofId(String proofId) async {
    return await _userRemoteDataSource.checkProofId(proofId);
  }

  @override
  Future<CitiesResponse> getCities() async {
    return await _genericRemoteDatasource.getCities();
  }

  @override
  Future<ColorsResponse> getColors() async {
    return await _genericRemoteDatasource.getColors();
  }

  @override
  Future<VehicleBrandsResponse> getVehicleBrands() async {
    return await _vehicleRemoteDatasource.getVehicleBrands();
  }

  @override
  Future<VehicleCountriesResponse> getVehicleCountries() async {
    return await _vehicleRemoteDatasource.getVehicleCountries();
  }

  @override
  Future<VehicleModelsResponse> getVehicleModels(int vehicleBrandId) async {
    return await _vehicleRemoteDatasource.getVehicleModels(vehicleBrandId);
  }

  @override
  Future<VehicleOwnershipTypesResponse> getVehicleOwnershipTypes() async {
    return await _vehicleRemoteDatasource.getVehicleOwnershipTypes();
  }

  @override
  Future<VehicleTypesResponse> getVehicleTypes() async {
    return await _vehicleRemoteDatasource.getVehicleTypes();
  }

  @override
  Future<BasicResponse> addVehicle(AddVehicleRequest request) async {
    return _vehicleRemoteDatasource.addVehicle(request);
  }

  @override
  Future<UserResponse> editProfile(EditProfileRequest request) async {
    return await _userRemoteDataSource.editProfile(request);
  }

  @override
  Future<BasicResponse> changePassword(ChangePasswordRequest request) async {
    return await _userRemoteDataSource.changePassword(request);
  }

  @override
  Future<VehiclesResponse> getMyVehicles(
      {int? page, bool isHidden = false}) async {
    return await _vehicleRemoteDatasource.getMyVehicles(
        page: page, isHidden: isHidden);
  }

  @override
  Future<CompaniesResponse> getCompanies(int? page) async {
    return await _genericRemoteDatasource.getCompanies(page);
  }

  @override
  Future<BranchesResponse> getCompanyBranches(int? companyId) async {
    return await _genericRemoteDatasource.getCompanyBranches(companyId);
  }

  @override
  Future<InsuranceTypesResponse> getInsuranceTypes() async {
    return await _insuranceRemoteDatasource.getInsuranceTypes();
  }

  @override
  Future<BasicResponse> calculateInsurancePriceByVehicle(
      CalculateInsurancePriceByVehicleRequest request) async {
    return await _insuranceRemoteDatasource
        .calculateInsurancePriceByVehicle(request);
  }

  @override
  Future<IssueInsuranceResponse> issueInsurance(
      IssueInsuranceRequest request) async {
    return await _insuranceRemoteDatasource.issueInsurance(request);
  }

  @override
  Future<BasicResponse> deactivate() async {
    return await _userRemoteDataSource.deactivate();
  }

  @override
  Future<BasicResponse> forgotPassword(String email) async {
    return await _userRemoteDataSource.forgotPassword(email);
  }

  @override
  Future<BasicResponse> resetPassword(ResetPasswordRequest request) async {
    return await _userRemoteDataSource.resetPassword(request);
  }

  @override
  Future<BasicResponse> verifyForgotPasswordOtp(
      VerifyOtpForgotPasswordRequest request) async {
    return await _userRemoteDataSource.verifyForgotPasswordOtp(request);
  }

  @override
  Future<InsurancesResponse> getMyInsurances({int? page}) async {
    return await _insuranceRemoteDatasource.getMyInsurances(page: page);
  }

  @override
  Future<BasicResponse> pay(int insuranceId) async {
    return await _insuranceRemoteDatasource.pay(insuranceId);
  }

  @override
  Future<AlarmTypesResponse> getAlarmTypes() async {
    return await _alarmRemoteDatasource.getAlarmTypes();
  }

  @override
  Future<BasicResponse> addAlarm(AddAlarmRequest request) async {
    return await _alarmRemoteDatasource.addAlarm(request);
  }

  @override
  Future<BasicResponse> toggleIsVehicleHidden(int vehicleId) async {
    return await _vehicleRemoteDatasource.toggleIsVehicleHidden(vehicleId);
  }

  @override
  Future<AlarmsResponse> getMyAlarms({int? page}) async {
    return await _alarmRemoteDatasource.getMyAlarms(page: page);
  }

  @override
  Future<NotificationsResponse> getNotifications() async {
    return await _genericRemoteDatasource.getNotifications();
  }

  @override
  Future<BasicResponse> toggleNotificationsIsSeen() async {
    return await _genericRemoteDatasource.toggleNotificationsIsSeen();
  }

  @override
  Future<BasicResponse> toggleNotificationIsRead(int id) async {
    return await _genericRemoteDatasource.toggleNotificationIsRead(id);
  }

  @override
  Future<BasicResponse> countUnseenNotifications() async {
    return await _genericRemoteDatasource.countUnseenNotifications();
  }

  @override
  Future<CompaniesPricesResponse> getCompaniesPrices(
      CompaniesPricesRequest request) async {
    return await _genericRemoteDatasource.getCompaniesPrices(request);
  }

  @override
  Future<BasicResponse> sendVerifyPhoneOtp(String phone) async {
    return await _userRemoteDataSource.sendVerifyPhoneOtp(phone);
  }

  @override
  Future<BasicResponse> checkNationalId(String nationalId) async {
    return await _userRemoteDataSource.checkNationalId(nationalId);
  }

  @override
  Future<BasicResponse> calculateInsurancePrice(
      CalculateInsurancePriceRequest request) async {
    return await _insuranceRemoteDatasource.calculateInsurancePrice(request);
  }

  @override
  Future<BasicResponse> countCompanies() async {
    return await _genericRemoteDatasource.countCompanies();
  }

  @override
  Future<InstallmentsResponse> getInsuranceInstallments(
      GetInsuranceInstallmentsRequest request) async {
    return await _insuranceRemoteDatasource.getInsuranceInstallments(request);
  }

  @override
  Future<BasicResponse> confirmEmail() async {
    return await _userRemoteDataSource.confirmEmail();
  }
}
