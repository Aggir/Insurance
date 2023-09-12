import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/datasources/remote_datasource.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/domain/entities/user.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/data/mapper/user_mapper.dart';

class UserRepositoryImpl extends UserRepository {
  final RemoteDataSource _remoteDataSource;
  UserRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> isLoggedIn() async {
    final response = await _remoteDataSource.isLoggedIn();
    if (response.user == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.user.toDomain());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(SignInRequest input) async {
    final response = await _remoteDataSource.signIn(input);
    if (response.user == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.user.toDomain());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final response = await _remoteDataSource.signOut();
    if (response.message != null) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(SignUpRequest input) async {
    final response = await _remoteDataSource.signUp(input);
    if (response.user == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.user.toDomain());
    }
  }

  @override
  Future<Either<Failure, void>> checkUserInfo(
      CheckUserInfoRequest input) async {
    final response = await _remoteDataSource.checkUserInfo(input);
    if (response.data == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> checkProofId(String proofId) async {
    final response = await _remoteDataSource.checkProofId(proofId);
    if (response.data == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> editProfile(
      EditProfileRequest input) async {
    final response = await _remoteDataSource.editProfile(input);
    if (response.user == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return Right(response.user.toDomain());
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      ChangePasswordRequest input) async {
    final response = await _remoteDataSource.changePassword(input);
    if (response.message != null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> deactivate() async {
    final response = await _remoteDataSource.deactivate();
    if (response.message != null) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    final response = await _remoteDataSource.forgotPassword(email);
    if (response.message != null) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      ResetPasswordRequest input) async {
    final response = await _remoteDataSource.resetPassword(input);
    if (response.message != null) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> verifyForgotPasswordOtp(
      VerifyOtpForgotPasswordRequest input) async {
    final response = await _remoteDataSource.verifyForgotPasswordOtp(input);
    if (response.message != null) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> sendVerifyPhoneOtp(String phone) async {
    final response = await _remoteDataSource.sendVerifyPhoneOtp(phone);
    if (response.message != null) {
      return Left(Failure(0, response.message!));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> checkNationalId(String nationalId) async {
    final response = await _remoteDataSource.checkNationalId(nationalId);
    if (response.data == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> confirmEmail() async {
    final response = await _remoteDataSource.confirmEmail();
    if (response.data == null) {
      return Left(Failure(
        response.code ?? 0,
        response.message ?? AppStrings.genericError.tr(),
      ));
    } else {
      return const Right(null);
    }
  }
}
