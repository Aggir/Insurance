import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';

abstract class BaseUserRemoteDataSource {
  Future<UserResponse> signIn(SignInRequest request);

  Future<BasicResponse> signOut();

  Future<UserResponse> signUp(SignUpRequest request);

  Future<UserResponse> isLoggedIn();

  Future<BasicResponse> checkUserInfo(CheckUserInfoRequest request);

  Future<BasicResponse> checkProofId(String proofId);

  Future<BasicResponse> checkNationalId(String nationalId);

  Future<UserResponse> editProfile(EditProfileRequest request);

  Future<BasicResponse> changePassword(ChangePasswordRequest request);

  Future<BasicResponse> deactivate();

  Future<BasicResponse> forgotPassword(String email);

  Future<BasicResponse> verifyForgotPasswordOtp(
      VerifyOtpForgotPasswordRequest request);

  Future<BasicResponse> resetPassword(ResetPasswordRequest request);

  Future<BasicResponse> sendVerifyPhoneOtp(String phone);

  Future<BasicResponse> confirmEmail();
}
