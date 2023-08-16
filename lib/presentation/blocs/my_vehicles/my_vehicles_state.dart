part of 'my_vehicles_cubit.dart';

class MyVehiclesState extends Equatable {
  final Status fetchMyVehiclesStatus;
  final String? fetchMyVehiclesErrorMessage;
  final Status fetchMoreVehiclesStatus;
  final String? fetchMoreVehiclesErrorMessage;
  final List<VehicleEntity>? myVehicles;
  final MetaEntity? meta;
  const MyVehiclesState({
    this.fetchMyVehiclesStatus = Status.initial,
    this.fetchMyVehiclesErrorMessage,
    this.fetchMoreVehiclesStatus = Status.initial,
    this.fetchMoreVehiclesErrorMessage,
    this.myVehicles,
    this.meta,
  });

  @override
  List<Object?> get props => [
        fetchMyVehiclesStatus,
        fetchMyVehiclesErrorMessage,
        fetchMoreVehiclesStatus,
        fetchMoreVehiclesErrorMessage,
        myVehicles,
        meta,
      ];

  MyVehiclesState copyWith({
    Status? fetchMyVehiclesStatus,
    String? fetchMyVehiclesErrorMessage,
    Status? fetchMoreVehiclesStatus,
    String? fetchMoreVehiclesErrorMessage,
    List<VehicleEntity>? myVehicles,
    MetaEntity? meta,
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
    );
  }

  @override
  String toString() {
    return 'MyVehiclesState(fetchMyVehiclesStatus: $fetchMyVehiclesStatus, fetchMyVehiclesErrorMessage: $fetchMyVehiclesErrorMessage, myVehicles: $myVehicles, meta: $meta)';
  }
}
