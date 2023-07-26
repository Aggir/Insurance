part of 'add_my_vehicle_cubit.dart';

@immutable
class AddMyVehicleState extends Equatable {
  final AddMyVehicleUserInfo? userInfo;

  const AddMyVehicleState({
    this.userInfo,
  });

  @override
  List<Object?> get props => [
        userInfo,
      ];

  AddMyVehicleState copyWith({
    AddMyVehicleUserInfo? userInfo,
  }) {
    return AddMyVehicleState(
      userInfo: userInfo ?? this.userInfo,
    );
  }

  // @override
  // String toString() {
  //   return 'AddMyVehicleState(userInfo: $userInfo, password: $password, isLibyan: $isLibyan, verificationType: $verificationType, verificationDocumentStatus: $verificationDocumentStatus, verificationDocumentInfo: $verificationDocumentInfo, nationalNumberStatus: $nationalNumberStatus, nationalIdInfo: $nationalIdInfo)';
  // }
}
