import 'package:get_it/get_it.dart';
import 'package:insurance_app/data/datasources/remote/api_constants.dart';
import 'package:insurance_app/data/datasources/remote/remote_datasource_impl.dart';
import 'package:insurance_app/data/datasources/remote_datasource.dart';
import 'package:insurance_app/data/repositories/user_repository_impl.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/check_proof_id_usecase.dart';
import 'package:insurance_app/domain/usecases/check_user_info.dart';
import 'package:insurance_app/domain/usecases/is_logged_in_usecase.dart';
import 'package:insurance_app/domain/usecases/sign_out_usecase.dart';
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
      headers: {'Accept': 'application/json'});
  final Dio dio = Dio(dioOptions);

  instance.registerLazySingleton<Dio>(() => dio);

  // remote database instance (Firebase Package)
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<Dio>(), instance<AppService>()),
  );

  // remote database instance (Firebase Package)
  instance.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(instance<RemoteDataSource>()),
  );

  // User Cubit
  instance.registerFactory(() => UserCubit());
  // internet Bloc
  instance.registerFactory(() => InternetBloc());
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

// void initChangePassword() async {
//   if (!GetIt.I.isRegistered<ChangePasswordUsecase>()) {
//     instance.registerFactory<ChangePasswordUsecase>(
//         () => ChangePasswordUsecase(instance<Repository>()));
//   }
// }

// void initEditProfile() async {
//   if (!GetIt.I.isRegistered<EditProfileUsecase>()) {
//     instance.registerFactory<EditProfileUsecase>(
//         () => EditProfileUsecase(instance<Repository>()));
//   }
// }
