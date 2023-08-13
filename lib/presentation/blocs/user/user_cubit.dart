import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/helpers/app_service.dart';
import 'package:insurance_app/domain/entities/national_document.dart';
import 'package:insurance_app/domain/entities/proof_document.dart';
import 'package:insurance_app/domain/entities/signup_user_info.dart';
import 'package:insurance_app/domain/entities/user.dart';
import 'package:insurance_app/domain/usecases/is_logged_in_usecase.dart';
import 'package:insurance_app/domain/usecases/sign_in_usecase.dart';
import 'package:insurance_app/domain/usecases/sign_out_usecase.dart';

import '../../../app/di/dependency_injection.dart';
import '../../../domain/usecases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<void> login(String emailOrPhone, String password) async {
    emit(state.copyWith(authStatus: Status.loading));
    initSignIn();
    (await instance<SignInUsecase>().execute(SignInUsecaseInput(
            emailAddressOrPhoneNumber: emailOrPhone, password: password)))
        .fold(
      (failure) {
        emit(state.copyWith(
            authStatus: Status.failure, authErrorMessage: failure.message));
      },
      (data) {
        emit(state.copyWith(authStatus: Status.success, user: data));
      },
    );
  }

  void signUp(SignUpUserInfo userInfo, String password, bool isLibyan,
      ProofDocument proofDocument,
      {NationalDocument? nationalDocument}) async {
    emit(state.copyWith(authStatus: Status.loading));
    initSignUp();
    (await instance<SignUpUsecase>().execute(SignUpUsecaseInput(
      userInfo: userInfo,
      password: password,
      isLibyan: isLibyan,
      proofDocument: proofDocument,
      nationalDocument: nationalDocument,
    )))
        .fold(
      (failure) {
        emit(state.copyWith(
            authStatus: Status.failure, authErrorMessage: failure.message));
      },
      (data) {
        emit(state.copyWith(authStatus: Status.success, user: data));
      },
    );
  }

  void isLoggedIn() async {
    if (instance<AppService>().token.isNotEmpty) {
      emit(state.copyWith(checkTokenStatus: Status.loading));
      initIsLoggedIn();
      (await instance<IsLoggedInUsecase>().execute(null)).fold(
        (failure) {
          emit(state.copyWith(
              checkTokenStatus: Status.failure,
              checkTokenErrorMessage: failure.message));
        },
        (data) {
          emit(state.copyWith(
              checkTokenStatus: Status.success,
              authStatus: Status.success,
              user: data));
        },
      );
    }
  }

  void logout() async {
    emit(state.copyWith(
      logoutStatus: Status.loading,
      authStatus: Status.loading,
    ));
    initSignOut();
    (await instance<SignOutUsecase>().execute(null)).fold(
      (failure) {
        emit(state.copyWith(
            logoutStatus: Status.failure,
            authStatus: Status.success,
            logoutErrorMessage: failure.message));
      },
      (data) {
        emit(const UserState());
      },
    );
  }
}
