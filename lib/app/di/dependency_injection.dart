import 'package:get_it/get_it.dart';
import 'package:insurance_app/data/datasources/remote/api_constants.dart';
import 'package:insurance_app/data/datasources/remote/remote_datasource_impl.dart';
import 'package:insurance_app/data/datasources/remote_datasource.dart';
import 'package:insurance_app/data/repositories/alarm_repository_impl.dart';
import 'package:insurance_app/data/repositories/insurance_repository_impl.dart';
import 'package:insurance_app/data/repositories/repository_impl.dart';
import 'package:insurance_app/data/repositories/user_repository_impl.dart';
import 'package:insurance_app/data/repositories/vehicle_repository_impl.dart';
import 'package:insurance_app/domain/repositories/alarm_repository.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/repositories/vehicle_repository.dart';
import 'package:insurance_app/domain/usecases/add_alarm_usecase.dart';
import 'package:insurance_app/domain/usecases/add_vehicle_usecase.dart';
import 'package:insurance_app/domain/usecases/calculate_insurance_price_usecase.dart';
import 'package:insurance_app/domain/usecases/change_password_usecase.dart';
import 'package:insurance_app/domain/usecases/check_proof_id_usecase.dart';
import 'package:insurance_app/domain/usecases/check_user_info.dart';
import 'package:insurance_app/domain/usecases/deactivate_usecase.dart';
import 'package:insurance_app/domain/usecases/edit_profile_usecase.dart';
import 'package:insurance_app/domain/usecases/forgot_password_usecase.dart';
import 'package:insurance_app/domain/usecases/get_add_vehicle_form_data_usecase.dart';
import 'package:insurance_app/domain/usecases/get_alarm_types_usecase.dart';
import 'package:insurance_app/domain/usecases/get_cities_usecase.dart';
import 'package:insurance_app/domain/usecases/get_colors_usecase.dart';
import 'package:insurance_app/domain/usecases/get_companies_usecase.dart';
import 'package:insurance_app/domain/usecases/get_company_branches_usecase.dart';
import 'package:insurance_app/domain/usecases/get_company_prices_form_usecase.dart';
import 'package:insurance_app/domain/usecases/get_insurance_form_data.dart';
import 'package:insurance_app/domain/usecases/get_my_insurances_usecase.dart';
import 'package:insurance_app/domain/usecases/get_my_vehicles_usecase.dart';
import 'package:insurance_app/domain/usecases/get_vehicle_models_usecase.dart';
import 'package:insurance_app/domain/usecases/is_logged_in_usecase.dart';
import 'package:insurance_app/domain/usecases/issue_insurance_usecase.dart';
import 'package:insurance_app/domain/usecases/pay_usecase.dart';
import 'package:insurance_app/domain/usecases/reset_password_usecase.dart';
import 'package:insurance_app/domain/usecases/sign_out_usecase.dart';
import 'package:insurance_app/domain/usecases/verify_forgot_password_otp_usecase.dart';
import 'package:insurance_app/presentation/blocs/internet/internet_bloc.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
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

void initGetInsuranceFormData() async {
  if (!GetIt.I.isRegistered<GetInsuranceFormData>()) {
    instance.registerFactory<GetInsuranceFormData>(
        () => GetInsuranceFormData(instance<InsuranceRepository>()));
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

void initGetCompanyPricesFormData() async {
  if (!GetIt.I.isRegistered<GetCompanyPricesFormUsecase>()) {
    instance.registerFactory<GetCompanyPricesFormUsecase>(
        () => GetCompanyPricesFormUsecase(instance<Repository>()));
  }
}
