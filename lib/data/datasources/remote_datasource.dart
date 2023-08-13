import 'package:insurance_app/data/responses/basic_response.dart';
import 'package:insurance_app/data/responses/user_response.dart';

import '../requests/requests.dart';

abstract class RemoteDataSource {
  Future<UserResponse> signIn(SignInRequest request);

  Future<BasicResponse> signOut();

  Future<UserResponse> signUp(SignUpRequest request);

  Future<UserResponse> isLoggedIn();

  Future<BasicResponse> checkUserInfo(CheckUserInfoRequest request);

  Future<BasicResponse> checkProofId(String proofId);
}
