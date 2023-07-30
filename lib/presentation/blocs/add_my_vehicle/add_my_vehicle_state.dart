part of 'add_my_vehicle_cubit.dart';

@immutable
class AddMyVehicleState extends Equatable {
  final AddMyVehicleUserInfo? userInfo;
  final Status vehiclePictureStatus;
  final bool isPublicUse;
  final Map<String, String>? carBrand;

  const AddMyVehicleState(
      {this.userInfo,
      this.vehiclePictureStatus = Status.initial,
      this.isPublicUse = false,
      this.carBrand});

  @override
  List<Object?> get props => [
        userInfo,
        vehiclePictureStatus,
        isPublicUse,
        carBrand,
      ];

  AddMyVehicleState copyWith(
      {AddMyVehicleUserInfo? userInfo,
      Status? vehiclePictureStatus,
      bool? isPublicUse,
      Map<String, String>? carBrand}) {
    return AddMyVehicleState(
      userInfo: userInfo ?? this.userInfo,
      vehiclePictureStatus: vehiclePictureStatus ?? this.vehiclePictureStatus,
      isPublicUse: isPublicUse ?? this.isPublicUse,
      carBrand: carBrand ?? this.carBrand,
    );
  }

  // @override
  // String toString() {
  //   return 'AddMyVehicleState(userInfo: $userInfo, password: $password, isLibyan: $isLibyan, verificationType: $verificationType, verificationDocumentStatus: $verificationDocumentStatus, verificationDocumentInfo: $verificationDocumentInfo, nationalNumberStatus: $nationalNumberStatus, nationalIdInfo: $nationalIdInfo)';
  // }
}
