import 'package:get_it/get_it.dart';
import 'package:insurance_app/data/datasources/index.dart';
import 'package:insurance_app/data/repositories/index.dart';
import 'package:insurance_app/domain/repositories/index.dart';
import 'package:insurance_app/domain/usecases/index.dart';
import 'package:insurance_app/presentation/blocs/compare_companies/compare_companies_cubit.dart';
import 'package:insurance_app/presentation/blocs/internet/internet_bloc.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../helpers/app_service.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Shared Preferences instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // App service instance
  instance.registerLazySingleton<AppService>(
      () => AppService(instance<SharedPreferences>())..onAppStart());

  // Dio instance
  final dioOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      //TODO: DYNAMIC LOCALE
      headers: {'Accept': 'application/json', 'locale': 'ar'});
  final Dio dio = Dio(dioOptions);

  instance.registerLazySingleton<Dio>(() => dio);

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<Dio>(), instance<AppService>()),
  );

  // Repositories
  instance.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(instance<RemoteDataSource>()),
  );

  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance<RemoteDataSource>()),
  );

  instance.registerLazySingleton<VehicleRepository>(
    () => VehicleRepositoryImpl(instance<RemoteDataSource>()),
  );

  instance.registerLazySingleton<InsuranceRepository>(
    () => InsuranceRepositoryImpl(instance<RemoteDataSource>()),
  );

  instance.registerLazySingleton<AlarmRepository>(
    () => AlarmRepositoryImpl(instance<RemoteDataSource>()),
  );

  // User Cubit
  instance.registerLazySingleton(() => UserCubit());
  // internet Bloc
  instance.registerLazySingleton(() => InternetBloc());
}

void initCompareCompaniesCubit() async {
  if (!GetIt.I.isRegistered<CompareCompaniesCubit>()) {
    instance.registerLazySingleton<CompareCompaniesCubit>(
        () => CompareCompaniesCubit());
  }
}

void initSignIn() async {
  if (!GetIt.I.isRegistered<SignInUsecase>()) {
    instance.registerFactory<SignInUsecase>(
        () => SignInUsecase(instance<UserRepository>()));
  }
}

void initSignOut() async {
  if (!GetIt.I.isRegistered<SignOutUsecase>()) {
    instance.registerFactory<SignOutUsecase>(
        () => SignOutUsecase(instance<UserRepository>()));
  }
}

void initSignUp() async {
  if (!GetIt.I.isRegistered<SignUpUsecase>()) {
    instance.registerFactory<SignUpUsecase>(
        () => SignUpUsecase(instance<UserRepository>()));
  }
}

void initIsLoggedIn() async {
  if (!GetIt.I.isRegistered<IsLoggedInUsecase>()) {
    instance.registerFactory<IsLoggedInUsecase>(
        () => IsLoggedInUsecase(instance<UserRepository>()));
  }
}

void initCheckUserInfo() async {
  if (!GetIt.I.isRegistered<CheckUserInfoUsecase>()) {
    instance.registerFactory<CheckUserInfoUsecase>(
        () => CheckUserInfoUsecase(instance<UserRepository>()));
  }
}

void initCheckProofId() async {
  if (!GetIt.I.isRegistered<CheckProofIdUsecase>()) {
    instance.registerFactory<CheckProofIdUsecase>(
        () => CheckProofIdUsecase(instance<UserRepository>()));
  }
}

void initCheckNationalId() async {
  if (!GetIt.I.isRegistered<CheckNationalIdUsecase>()) {
    instance.registerFactory<CheckNationalIdUsecase>(
        () => CheckNationalIdUsecase(instance<UserRepository>()));
  }
}

void initEditProfile() async {
  if (!GetIt.I.isRegistered<EditProfileUsecase>()) {
    instance.registerFactory<EditProfileUsecase>(
        () => EditProfileUsecase(instance<UserRepository>()));
  }
}

void initChangePassword() async {
  if (!GetIt.I.isRegistered<ChangePasswordUsecase>()) {
    instance.registerFactory<ChangePasswordUsecase>(
        () => ChangePasswordUsecase(instance<UserRepository>()));
  }
}

void initGetCities() async {
  if (!GetIt.I.isRegistered<GetCitiesUsecase>()) {
    instance.registerFactory<GetCitiesUsecase>(
        () => GetCitiesUsecase(instance<Repository>()));
  }
}

void initGetColors() async {
  if (!GetIt.I.isRegistered<GetColorsUsecase>()) {
    instance.registerFactory<GetColorsUsecase>(
        () => GetColorsUsecase(instance<Repository>()));
  }
}

void initGetCompaniesCount() async {
  if (!GetIt.I.isRegistered<GetCompaniesCountUsecase>()) {
    instance.registerFactory<GetCompaniesCountUsecase>(
        () => GetCompaniesCountUsecase(instance<Repository>()));
  }
}

void initGetCompanies() async {
  if (!GetIt.I.isRegistered<GetCompaniesUsecase>()) {
    instance.registerFactory<GetCompaniesUsecase>(
        () => GetCompaniesUsecase(instance<Repository>()));
  }
}

void initGetCompanyBranches() async {
  if (!GetIt.I.isRegistered<GetCompanyBranchesUsecase>()) {
    instance.registerFactory<GetCompanyBranchesUsecase>(
        () => GetCompanyBranchesUsecase(instance<Repository>()));
  }
}

void initGetAddVehicleFormData() async {
  if (!GetIt.I.isRegistered<GetAddVehicleFormDataUsecase>()) {
    instance.registerFactory<GetAddVehicleFormDataUsecase>(
        () => GetAddVehicleFormDataUsecase(instance<VehicleRepository>()));
  }
}

void initGetVehicleModels() async {
  if (!GetIt.I.isRegistered<GetVehicleModelsUsecase>()) {
    instance.registerFactory<GetVehicleModelsUsecase>(
        () => GetVehicleModelsUsecase(instance<VehicleRepository>()));
  }
}

void initAddVehicle() async {
  if (!GetIt.I.isRegistered<AddVehicleUsecase>()) {
    instance.registerFactory<AddVehicleUsecase>(
        () => AddVehicleUsecase(instance<VehicleRepository>()));
  }
}

void initGetMyVehicles() async {
  if (!GetIt.I.isRegistered<GetMyVehiclesUsecase>()) {
    instance.registerFactory<GetMyVehiclesUsecase>(
        () => GetMyVehiclesUsecase(instance<VehicleRepository>()));
  }
}

void initToggleIsVehicleHidden() async {
  if (!GetIt.I.isRegistered<ToggleIsVehicleHiddenUsecase>()) {
    instance.registerFactory<ToggleIsVehicleHiddenUsecase>(
        () => ToggleIsVehicleHiddenUsecase(instance<VehicleRepository>()));
  }
}

void initGetInsuranceFormData() async {
  if (!GetIt.I.isRegistered<GetInsuranceFormData>()) {
    instance.registerFactory<GetInsuranceFormData>(
        () => GetInsuranceFormData(instance<InsuranceRepository>()));
  }
}

void initCalculateInsurancePriceByVehicle() async {
  if (!GetIt.I.isRegistered<CalculateInsurancePriceByVehicleUsecase>()) {
    instance.registerFactory<CalculateInsurancePriceByVehicleUsecase>(() =>
        CalculateInsurancePriceByVehicleUsecase(
            instance<InsuranceRepository>()));
  }
}

void initCalculateInsurancePrice() async {
  if (!GetIt.I.isRegistered<CalculateInsurancePriceUsecase>()) {
    instance.registerFactory<CalculateInsurancePriceUsecase>(
        () => CalculateInsurancePriceUsecase(instance<InsuranceRepository>()));
  }
}

void initIssueInsurance() async {
  if (!GetIt.I.isRegistered<IssueInsuranceUsecase>()) {
    instance.registerFactory<IssueInsuranceUsecase>(
        () => IssueInsuranceUsecase(instance<InsuranceRepository>()));
  }
}

void initGetMyInsurances() async {
  if (!GetIt.I.isRegistered<GetMyInsurancesUsecase>()) {
    instance.registerFactory<GetMyInsurancesUsecase>(
        () => GetMyInsurancesUsecase(instance<InsuranceRepository>()));
  }
}

void initGetInsuranceTypes() async {
  if (!GetIt.I.isRegistered<GetInsuranceTypesUsecase>()) {
    instance.registerFactory<GetInsuranceTypesUsecase>(
        () => GetInsuranceTypesUsecase(instance<InsuranceRepository>()));
  }
}

void initCompareCompaniesPrices() async {
  if (!GetIt.I.isRegistered<CompareCompaniesPricesUsecase>()) {
    instance.registerFactory<CompareCompaniesPricesUsecase>(
        () => CompareCompaniesPricesUsecase(instance<InsuranceRepository>()));
  }
}

void initPay() async {
  if (!GetIt.I.isRegistered<PayUsecase>()) {
    instance.registerFactory<PayUsecase>(
        () => PayUsecase(instance<InsuranceRepository>()));
  }
}

void initDeactivate() async {
  if (!GetIt.I.isRegistered<DeactivateUsecase>()) {
    instance.registerFactory<DeactivateUsecase>(
        () => DeactivateUsecase(instance<UserRepository>()));
  }
}

void initForgotPassword() async {
  if (!GetIt.I.isRegistered<ForgotPasswordUsecase>()) {
    instance.registerFactory<ForgotPasswordUsecase>(
        () => ForgotPasswordUsecase(instance<UserRepository>()));
  }
}

void initVerifyForgotPasswordOtp() async {
  if (!GetIt.I.isRegistered<VerifyForgotPasswordOtpUsecase>()) {
    instance.registerFactory<VerifyForgotPasswordOtpUsecase>(
        () => VerifyForgotPasswordOtpUsecase(instance<UserRepository>()));
  }
}

void initResetPassword() async {
  if (!GetIt.I.isRegistered<ResetPasswordUsecase>()) {
    instance.registerFactory<ResetPasswordUsecase>(
        () => ResetPasswordUsecase(instance<UserRepository>()));
  }
}

void initGetAlarmTypes() async {
  if (!GetIt.I.isRegistered<GetAlarmTypesUsecase>()) {
    instance.registerFactory<GetAlarmTypesUsecase>(
        () => GetAlarmTypesUsecase(instance<AlarmRepository>()));
  }
}

void initAddAlarm() async {
  if (!GetIt.I.isRegistered<AddAlarmUsecase>()) {
    instance.registerFactory<AddAlarmUsecase>(
        () => AddAlarmUsecase(instance<AlarmRepository>()));
  }
}

void initGetMyAlarms() async {
  if (!GetIt.I.isRegistered<GetMyAlarmsUsecase>()) {
    instance.registerFactory<GetMyAlarmsUsecase>(
        () => GetMyAlarmsUsecase(instance<AlarmRepository>()));
  }
}

void initGetCompanyPricesFormData() async {
  if (!GetIt.I.isRegistered<GetCompanyPricesFormUsecase>()) {
    instance.registerFactory<GetCompanyPricesFormUsecase>(
        () => GetCompanyPricesFormUsecase(instance<Repository>()));
  }
}

void initGetNotifications() async {
  if (!GetIt.I.isRegistered<GetNotificationsUsecase>()) {
    instance.registerFactory<GetNotificationsUsecase>(
        () => GetNotificationsUsecase(instance<Repository>()));
  }
}

void initNotificationsSeen() async {
  if (!GetIt.I.isRegistered<NotificationsSeenUsecase>()) {
    instance.registerFactory<NotificationsSeenUsecase>(
        () => NotificationsSeenUsecase(instance<Repository>()));
  }
}

void initNotificationsRead() async {
  if (!GetIt.I.isRegistered<NotificationReadUsecase>()) {
    instance.registerFactory<NotificationReadUsecase>(
        () => NotificationReadUsecase(instance<Repository>()));
  }
}

void initCountUnseenNotifications() async {
  if (!GetIt.I.isRegistered<CountUnseenNotificationsUsecase>()) {
    instance.registerFactory<CountUnseenNotificationsUsecase>(
        () => CountUnseenNotificationsUsecase(instance<Repository>()));
  }
}

void initSignUpSendVerifyPhoneOtp() async {
  if (!GetIt.I.isRegistered<SendVerifyPhoneOtpUsecase>()) {
    instance.registerFactory<SendVerifyPhoneOtpUsecase>(
        () => SendVerifyPhoneOtpUsecase(instance<UserRepository>()));
  }
}

void initGetInsuranceInstallments() async {
  if (!GetIt.I.isRegistered<GetInsuranceInstallmentsUsecase>()) {
    instance.registerFactory<GetInsuranceInstallmentsUsecase>(
        () => GetInsuranceInstallmentsUsecase(instance<InsuranceRepository>()));
  }
}

void initConfirmEmail() async {
  if (!GetIt.I.isRegistered<ConfirmEmailUsecase>()) {
    instance.registerFactory<ConfirmEmailUsecase>(
        () => ConfirmEmailUsecase(instance<UserRepository>()));
  }
}
