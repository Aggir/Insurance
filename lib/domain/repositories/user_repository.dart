import 'package:dartz/dartz.dart';

import '../../app/failure.dart';
import '../../data/requests/user_requests.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> signIn(SignInRequest input);

  Future<Either<Failure, UserEntity>> isLoggedIn();

  Future<Either<Failure, UserEntity>> signUp(SignUpRequest input);

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> checkUserInfo(CheckUserInfoRequest input);

  Future<Either<Failure, void>> checkProofId(String proofId);

  Future<Either<Failure, void>> checkNationalId(String nationalId);

  Future<Either<Failure, UserEntity>> editProfile(EditProfileRequest input);

  Future<Either<Failure, void>> changePassword(ChangePasswordRequest input);

  Future<Either<Failure, void>> deactivate();

  Future<Either<Failure, void>> forgotPassword(String email);

  Future<Either<Failure, void>> verifyForgotPasswordOtp(
      VerifyOtpForgotPasswordRequest input);

  Future<Either<Failure, void>> resetPassword(ResetPasswordRequest input);

  Future<Either<Failure, void>> sendVerifyPhoneOtp(String phone);

  Future<Either<Failure, void>> confirmEmail();
}
