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
    );
  }

  @override
  String toString() {
    return 'MyVehiclesState(fetchMyVehiclesStatus: $fetchMyVehiclesStatus, fetchMyVehiclesErrorMessage: $fetchMyVehiclesErrorMessage, myVehicles: $myVehicles, meta: $meta)';
  }
}
