import 'package:insurance_app/data/datasources/remote/base/base_user_remote_datasource.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';

class UserRemoteDatasource implements BaseUserRemoteDataSource {
  @override
  Future<BasicResponse> changePassword(ChangePasswordRequest request) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> checkNationalId(String nationalId) {
    // TODO: implement checkNationalId
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> checkProofId(String proofId) {
    // TODO: implement checkProofId
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> checkUserInfo(CheckUserInfoRequest request) {
    // TODO: implement checkUserInfo
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> confirmEmail() {
    // TODO: implement confirmEmail
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> deactivate() {
    // TODO: implement deactivate
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> editProfile(EditProfileRequest request) {
    // TODO: implement editProfile
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> resetPassword(ResetPasswordRequest request) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> sendVerifyPhoneOtp(String phone) {
    // TODO: implement sendVerifyPhoneOtp
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> signIn(SignInRequest request) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> signUp(SignUpRequest request) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<BasicResponse> verifyForgotPasswordOtp(
      VerifyOtpForgotPasswordRequest request) {
    // TODO: implement verifyForgotPasswordOtp
    throw UnimplementedError();
  }
}
