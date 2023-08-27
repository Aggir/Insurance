part of 'my_alarms_cubit.dart';

class MyAlarmsState extends Equatable {
  final Status fetchMyAlarmsStatus;
  final String? fetchMyAlarmsErrorMessage;
  final List<AlarmEntity>? myAlarms;
  final MetaEntity? meta;
  final Status fetchMoreAlarmsStatus;
  final String? fetchMoreAlarmsErrorMessage;

  const MyAlarmsState({
    this.fetchMyAlarmsStatus = Status.initial,
    this.fetchMyAlarmsErrorMessage,
    this.myAlarms,
    this.meta,
    this.fetchMoreAlarmsStatus = Status.initial,
    this.fetchMoreAlarmsErrorMessage,
  });

  @override
  List<Object?> get props => [
        fetchMyAlarmsStatus,
        fetchMyAlarmsErrorMessage,
        myAlarms,
        meta,
        fetchMoreAlarmsStatus,
        fetchMoreAlarmsErrorMessage,
      ];

  MyAlarmsState copyWith({
    Status? fetchMyAlarmsStatus,
    String? fetchMyAlarmsErrorMessage,
    List<AlarmEntity>? myAlarms,
    MetaEntity? meta,
    Status? fetchMoreAlarmsStatus,
    String? fetchMoreAlarmsErrorMessage,
  }) {
    return MyAlarmsState(
      fetchMyAlarmsStatus: fetchMyAlarmsStatus ?? this.fetchMyAlarmsStatus,
      fetchMyAlarmsErrorMessage:
          fetchMyAlarmsErrorMessage ?? this.fetchMyAlarmsErrorMessage,
      myAlarms: myAlarms ?? this.myAlarms,
      meta: meta ?? this.meta,
      fetchMoreAlarmsStatus:
          fetchMoreAlarmsStatus ?? this.fetchMoreAlarmsStatus,
      fetchMoreAlarmsErrorMessage:
          fetchMoreAlarmsErrorMessage ?? this.fetchMoreAlarmsErrorMessage,
    );
  }
}
