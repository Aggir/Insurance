part of 'add_my_vehicle_cubit.dart';

@immutable
class AddMyVehicleState extends Equatable {
  final Vehicle? userInfo;
  final Status getCitiesStatus;
  final String? getCitiesErrorMessage;
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
  final int? selectedVehicleCountryId;
  final int? selectedVehicleYearId;
  final int? selectedVehicleHorsePower;
  final int? selectedVehicleColorId;
  final int? selectedVehicleSeats;
  final VehicleBrandEntity? selectedVehicleBrand;
  final List<CityEntity>? cities;
  final Status vehiclePictureStatus;
  final File? vehiclePictureFile;
  final String? vehiclePictureFileName;
  final int? selectedVehicleOwnershipTypeId;
  final Status addVehicleStatus;
  final String? addVehicleErrorMessage;

  const AddMyVehicleState({
    this.userInfo,
    this.vehiclePictureStatus = Status.initial,
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
    this.selectedVehicleCountryId,
    this.selectedVehicleYearId,
    this.selectedVehicleHorsePower,
    this.selectedVehicleColorId,
    this.selectedVehicleSeats,
    this.selectedVehicleBrand,
    this.vehiclePictureFile,
    this.vehiclePictureFileName,
    this.cities,
    this.selectedVehicleOwnershipTypeId,
    this.addVehicleStatus = Status.initial,
    this.addVehicleErrorMessage,
  });

  @override
  List<Object?> get props => [
        userInfo,
        vehiclePictureStatus,
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
        selectedVehicleCountryId,
        selectedVehicleYearId,
        selectedVehicleHorsePower,
        selectedVehicleColorId,
        selectedVehicleSeats,
        cities,
        vehiclePictureFile,
        vehiclePictureFileName,
        selectedVehicleOwnershipTypeId,
        selectedVehicleBrand,
        addVehicleStatus,
        addVehicleErrorMessage,
      ];

  AddMyVehicleState copyWith({
    Vehicle? userInfo,
    Status? vehiclePictureStatus,
    Status? getCitiesStatus,
    String? getCitiesErrorMessage,
    Status? getAddVehicleFormDataStatus,
    String? getAddVehicleFormDataErrorMessage,
    AddVehicleFormData? addVehicleFormData,
    Status? getColorsStatus,
    String? getColorsErrorMessage,
    List<ColorEntity>? colors,
    int? selectedVehicleTypeId,
    int? selectedVehicleModelId,
    int? selectedVehicleCountryId,
    int? selectedVehicleYearId,
    int? selectedOwnerCityId,
    int? selectedVehicleCityId,
    int? selectedVehicleHorsePower,
    int? selectedVehicleColorId,
    int? selectedVehicleSeats,
    List<CityEntity>? cities,
    File? vehiclePictureFile,
    String? vehiclePictureFileName,
    int? selectedVehicleOwnershipTypeId,
    VehicleBrandEntity? selectedVehicleBrand,
    bool removeVehiclePicture = false,
    Status? addVehicleStatus,
    String? addVehicleErrorMessage,
  }) {
    return AddMyVehicleState(
      addVehicleStatus: addVehicleStatus ?? this.addVehicleStatus,
      addVehicleErrorMessage:
          addVehicleErrorMessage ?? this.addVehicleErrorMessage,
      vehiclePictureFile: removeVehiclePicture
          ? null
          : vehiclePictureFile ?? this.vehiclePictureFile,
      selectedVehicleCityId:
          selectedVehicleCityId ?? this.selectedVehicleCityId,
      vehiclePictureFileName: removeVehiclePicture
          ? null
          : vehiclePictureFileName ?? this.vehiclePictureFileName,
      selectedVehicleHorsePower:
          selectedVehicleHorsePower ?? this.selectedVehicleHorsePower,
      selectedVehicleColorId:
          selectedVehicleColorId ?? this.selectedVehicleColorId,
      selectedVehicleSeats: selectedVehicleSeats ?? this.selectedVehicleSeats,
      selectedVehicleTypeId:
          selectedVehicleTypeId ?? this.selectedVehicleTypeId,
      selectedVehicleModelId:
          selectedVehicleModelId ?? this.selectedVehicleModelId,
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
      selectedVehicleOwnershipTypeId:
          selectedVehicleOwnershipTypeId ?? this.selectedVehicleOwnershipTypeId,
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
    );
  }
}
