import 'package:insurance_app/data/models/branch_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class BranchesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<BranchModel>? branches;

  BranchesResponse({
    this.code,
    this.message,
    this.branches,
  });

  factory BranchesResponse.fromMap(Map<String, dynamic> map) {
    return BranchesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      branches: map['branches'] != null
          ? List<BranchModel>.from(
              map['branches']?.map((x) => BranchModel.fromMap(x)))
          : null,
    );
  }
}
