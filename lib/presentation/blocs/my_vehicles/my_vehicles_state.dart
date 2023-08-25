part of 'my_vehicles_cubit.dart';

class MyVehiclesState extends Equatable {
  final Status fetchMyVehiclesStatus;
  final String? fetchMyVehiclesErrorMessage;
  final Status fetchMoreVehiclesStatus;
  final String? fetchMoreVehiclesErrorMessage;
  final List<VehicleEntity>? myVehicles;
  final MetaEntity? meta;
  final Status fetchMyHiddenVehiclesStatus;
  final String? fetchMyHiddenVehiclesErrorMessage;
  final Status fetchMoreHiddenVehiclesStatus;
  final String? fetchMoreHiddenVehiclesErrorMessage;
  final List<VehicleEntity>? myHiddenVehicles;
  final MetaEntity? hiddenMeta;
  final int? selectedVehicleToHide;
  final Status toggleIsVehicleHiddenStatus;
  final String? toggleIsVehicleHiddenErrorMessage;
  const MyVehiclesState({
    this.fetchMyVehiclesStatus = Status.initial,
    this.fetchMyVehiclesErrorMessage,
    this.fetchMoreVehiclesStatus = Status.initial,
    this.fetchMoreVehiclesErrorMessage,
    this.myVehicles,
    this.meta,
    this.fetchMyHiddenVehiclesStatus = Status.initial,
    this.fetchMyHiddenVehiclesErrorMessage,
    this.fetchMoreHiddenVehiclesStatus = Status.initial,
    this.fetchMoreHiddenVehiclesErrorMessage,
    this.myHiddenVehicles,
    this.hiddenMeta,
    this.selectedVehicleToHide,
    this.toggleIsVehicleHiddenStatus = Status.initial,
    this.toggleIsVehicleHiddenErrorMessage,
  });

  @override
  List<Object?> get props => [
        fetchMyVehiclesStatus,
        fetchMyVehiclesErrorMessage,
        fetchMoreVehiclesStatus,
        fetchMoreVehiclesErrorMessage,
        myVehicles,
        meta,
        fetchMyHiddenVehiclesStatus,
        fetchMyHiddenVehiclesErrorMessage,
        fetchMoreHiddenVehiclesStatus,
        fetchMoreHiddenVehiclesErrorMessage,
        myHiddenVehicles,
        hiddenMeta,
        selectedVehicleToHide,
        toggleIsVehicleHiddenStatus,
        toggleIsVehicleHiddenErrorMessage,
      ];

  MyVehiclesState copyWith({
    Status? fetchMyVehiclesStatus,
    String? fetchMyVehiclesErrorMessage,
    Status? fetchMoreVehiclesStatus,
    String? fetchMoreVehiclesErrorMessage,
    List<VehicleEntity>? myVehicles,
    MetaEntity? meta,
    Status? fetchMyHiddenVehiclesStatus,
    String? fetchMyHiddenVehiclesErrorMessage,
    Status? fetchMoreHiddenVehiclesStatus,
    String? fetchMoreHiddenVehiclesErrorMessage,
    List<VehicleEntity>? myHiddenVehicles,
    MetaEntity? hiddenMeta,
    int? selectedVehicleToHide,
    Status? toggleIsVehicleHiddenStatus,
    String? toggleIsVehicleHiddenErrorMessage,
  }) {
    return MyVehiclesState(
      fetchMyVehiclesStatus:
          fetchMyVehiclesStatus ?? this.fetchMyVehiclesStatus,
      fetchMyVehiclesErrorMessage:
          fetchMyVehiclesErrorMessage ?? this.fetchMyVehiclesErrorMessage,
      fetchMoreVehiclesStatus:
          fetchMoreVehiclesStatus ?? this.fetchMoreVehiclesStatus,
      fetchMoreVehiclesErrorMessage:
          fetchMoreVehiclesErrorMessage ?? this.fetchMoreVehiclesErrorMessage,
      myVehicles: myVehicles ?? this.myVehicles,
      meta: meta ?? this.meta,
      fetchMyHiddenVehiclesStatus:
          fetchMyHiddenVehiclesStatus ?? this.fetchMyHiddenVehiclesStatus,
      fetchMyHiddenVehiclesErrorMessage: fetchMyHiddenVehiclesErrorMessage ??
          this.fetchMyHiddenVehiclesErrorMessage,
      fetchMoreHiddenVehiclesStatus:
          fetchMoreHiddenVehiclesStatus ?? this.fetchMoreHiddenVehiclesStatus,
      fetchMoreHiddenVehiclesErrorMessage:
          fetchMoreHiddenVehiclesErrorMessage ??
              this.fetchMoreHiddenVehiclesErrorMessage,
      myHiddenVehicles: myHiddenVehicles ?? this.myHiddenVehicles,
      hiddenMeta: hiddenMeta ?? this.hiddenMeta,
      selectedVehicleToHide:
          selectedVehicleToHide ?? this.selectedVehicleToHide,
      toggleIsVehicleHiddenStatus:
          toggleIsVehicleHiddenStatus ?? this.toggleIsVehicleHiddenStatus,
      toggleIsVehicleHiddenErrorMessage: toggleIsVehicleHiddenErrorMessage ??
          this.toggleIsVehicleHiddenErrorMessage,
    );
  }

  @override
  String toString() {
    return 'MyVehiclesState(fetchMyVehiclesStatus: $fetchMyVehiclesStatus, fetchMyVehiclesErrorMessage: $fetchMyVehiclesErrorMessage, fetchMoreVehiclesStatus: $fetchMoreVehiclesStatus, fetchMoreVehiclesErrorMessage: $fetchMoreVehiclesErrorMessage, myVehicles: ${myVehicles?.length}, meta: $meta, fetchMyHiddenVehiclesStatus: $fetchMyHiddenVehiclesStatus, fetchMyHiddenVehiclesErrorMessage: $fetchMyHiddenVehiclesErrorMessage, fetchMoreHiddenVehiclesStatus: $fetchMoreHiddenVehiclesStatus, fetchMoreHiddenVehiclesErrorMessage: $fetchMoreHiddenVehiclesErrorMessage, myHiddenVehicles: ${myHiddenVehicles?.length}, hiddenMeta: $hiddenMeta, selectedVehicleToHide: $selectedVehicleToHide, toggleIsVehicleHiddenStatus: $toggleIsVehicleHiddenStatus, toggleIsVehicleHiddenErrorMessage: $toggleIsVehicleHiddenErrorMessage)';
  }
}
