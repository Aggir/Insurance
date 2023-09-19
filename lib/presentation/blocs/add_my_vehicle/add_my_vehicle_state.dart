part of 'add_my_vehicle_cubit.dart';

@immutable
class AddMyVehicleState extends Equatable {
  final VehicleOwnerInfo? userInfo;
  final Status getCitiesStatus;
  final String? getCitiesErrorMessage;
  final String? ownerPhoneCode;
  final Status getAddVehicleFormDataStatus;
  final String? getAddVehicleFormDataErrorMessage;
  final AddVehicleFormData? addVehicleFormData;
  final Status getColorsStatus;
  final String? getColorsErrorMessage;
  final List<ColorEntity>? colors;
  final int? selectedOwnerCityId;
  final int? selectedVehicleCityId;
  final int? selectedVehicleTypeId;
  final int? selectedVehicleModelId;
  final String? selectedVehicleModel;
  final int? selectedVehicleCountryId;
  final int? selectedVehicleYearId;
  final bool? selectedVehicleWithAttachment;
  final int? selectedVehicleColorId;
  final VehicleBrandEntity? selectedVehicleBrand;
  final List<CityEntity>? cities;
  final Status vehiclePictureStatus;
  final File? vehiclePictureFile;
  final String? vehiclePictureFileName;
  final Status addVehicleStatus;
  final String? addVehicleErrorMessage;
  final Status vehicleBookletPictureStatus;
  final File? vehicleBookletPicture;
  final String? vehicleBookletPictureFileName;

  const AddMyVehicleState({
    this.userInfo,
    this.vehiclePictureStatus = Status.initial,
    this.ownerPhoneCode,
    this.getCitiesStatus = Status.initial,
    this.getCitiesErrorMessage,
    this.getAddVehicleFormDataStatus = Status.initial,
    this.getAddVehicleFormDataErrorMessage,
    this.addVehicleFormData,
    this.getColorsStatus = Status.initial,
    this.getColorsErrorMessage,
    this.colors,
    this.selectedOwnerCityId,
    this.selectedVehicleCityId,
    this.selectedVehicleTypeId,
    this.selectedVehicleModelId,
    this.selectedVehicleModel,
    this.selectedVehicleCountryId,
    this.selectedVehicleYearId,
    this.selectedVehicleWithAttachment,
    this.selectedVehicleColorId,
    this.selectedVehicleBrand,
    this.vehiclePictureFile,
    this.vehiclePictureFileName,
    this.cities,
    this.addVehicleStatus = Status.initial,
    this.addVehicleErrorMessage,
    this.vehicleBookletPictureStatus = Status.initial,
    this.vehicleBookletPicture,
    this.vehicleBookletPictureFileName,
  });

  @override
  List<Object?> get props => [
        userInfo,
        vehiclePictureStatus,
        ownerPhoneCode,
        getCitiesStatus,
        getCitiesErrorMessage,
        getAddVehicleFormDataStatus,
        addVehicleFormData,
        getAddVehicleFormDataErrorMessage,
        getColorsStatus,
        getColorsErrorMessage,
        colors,
        selectedOwnerCityId,
        selectedVehicleCityId,
        selectedVehicleTypeId,
        selectedVehicleModelId,
        selectedVehicleModel,
        selectedVehicleCountryId,
        selectedVehicleYearId,
        selectedVehicleWithAttachment,
        selectedVehicleColorId,
        cities,
        vehiclePictureFile,
        vehiclePictureFileName,
        selectedVehicleBrand,
        addVehicleStatus,
        addVehicleErrorMessage,
        vehicleBookletPictureStatus,
        vehicleBookletPicture,
        vehicleBookletPictureFileName,
      ];

  AddMyVehicleState copyWith({
    VehicleOwnerInfo? userInfo,
    Status? vehiclePictureStatus,
    Status? getCitiesStatus,
    String? ownerPhoneCode,
    String? getCitiesErrorMessage,
    Status? getAddVehicleFormDataStatus,
    String? getAddVehicleFormDataErrorMessage,
    AddVehicleFormData? addVehicleFormData,
    Status? getColorsStatus,
    String? getColorsErrorMessage,
    List<ColorEntity>? colors,
    int? selectedVehicleTypeId,
    int? selectedVehicleModelId,
    String? selectedVehicleModel,
    int? selectedVehicleCountryId,
    int? selectedVehicleYearId,
    int? selectedOwnerCityId,
    int? selectedVehicleCityId,
    bool? selectedVehicleWithAttachment,
    int? selectedVehicleColorId,
    List<CityEntity>? cities,
    File? vehiclePictureFile,
    String? vehiclePictureFileName,
    VehicleBrandEntity? selectedVehicleBrand,
    bool removeVehiclePicture = false,
    Status? addVehicleStatus,
    String? addVehicleErrorMessage,
    Status? vehicleBookletPictureStatus,
    File? vehicleBookletPicture,
    String? vehicleBookletPictureFileName,
    bool removeVehicleBooklet = false,
  }) {
    return AddMyVehicleState(
        addVehicleStatus: addVehicleStatus ?? this.addVehicleStatus,
        addVehicleErrorMessage:
            addVehicleErrorMessage ?? this.addVehicleErrorMessage,
        ownerPhoneCode: ownerPhoneCode ?? this.ownerPhoneCode,
        vehiclePictureFile: removeVehiclePicture
            ? null
            : vehiclePictureFile ?? this.vehiclePictureFile,
        selectedVehicleCityId:
            selectedVehicleCityId ?? this.selectedVehicleCityId,
        vehiclePictureFileName: removeVehiclePicture
            ? null
            : vehiclePictureFileName ?? this.vehiclePictureFileName,
        selectedVehicleWithAttachment:
            selectedVehicleWithAttachment ?? this.selectedVehicleWithAttachment,
        selectedVehicleColorId:
            selectedVehicleColorId ?? this.selectedVehicleColorId,
        selectedVehicleTypeId:
            selectedVehicleTypeId ?? this.selectedVehicleTypeId,
        selectedVehicleModelId:
            selectedVehicleModelId ?? this.selectedVehicleModelId,
        selectedVehicleModel: selectedVehicleModel ?? this.selectedVehicleModel,
        selectedVehicleCountryId:
            selectedVehicleCountryId ?? this.selectedVehicleCountryId,
        selectedVehicleYearId:
            selectedVehicleYearId ?? this.selectedVehicleYearId,
        userInfo: userInfo ?? this.userInfo,
        getColorsStatus: getColorsStatus ?? this.getColorsStatus,
        getColorsErrorMessage:
            getColorsErrorMessage ?? this.getColorsErrorMessage,
        colors: colors ?? this.colors,
        vehiclePictureStatus: vehiclePictureStatus ?? this.vehiclePictureStatus,
        getCitiesStatus: getCitiesStatus ?? this.getCitiesStatus,
        getAddVehicleFormDataStatus:
            getAddVehicleFormDataStatus ?? this.getAddVehicleFormDataStatus,
        getAddVehicleFormDataErrorMessage: getAddVehicleFormDataErrorMessage ??
            this.getAddVehicleFormDataErrorMessage,
        addVehicleFormData: addVehicleFormData ?? this.addVehicleFormData,
        selectedOwnerCityId: selectedOwnerCityId ?? this.selectedOwnerCityId,
        getCitiesErrorMessage:
            getCitiesErrorMessage ?? this.getCitiesErrorMessage,
        cities: cities ?? this.cities,
        selectedVehicleBrand: selectedVehicleBrand ?? this.selectedVehicleBrand,
        vehicleBookletPictureStatus:
            vehicleBookletPictureStatus ?? this.vehicleBookletPictureStatus,
        vehicleBookletPicture: removeVehicleBooklet
            ? null
            : vehicleBookletPicture ?? this.vehicleBookletPicture,
        vehicleBookletPictureFileName: vehicleBookletPictureFileName ??
            this.vehicleBookletPictureFileName);
  }
}
