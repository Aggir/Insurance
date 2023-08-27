part of 'add_reminder_cubit.dart';

class AddReminderState extends Equatable {
  final Status fetchAlarmTypesStatus;
  final String? fetchAlarmTypesErrorMessage;
  final List<AlarmTypesEntity>? alarmTypes;
  final int? selectedTypeId;
  final int? selectedTime;
  final Status insurancePictureStatus;
  final File? insurancePicture;
  final String? insurancePictureName;
  final Status addReminderStatus;
  final String? addReminderErrorMessage;
  const AddReminderState({
    this.fetchAlarmTypesStatus = Status.initial,
    this.fetchAlarmTypesErrorMessage,
    this.alarmTypes,
    this.selectedTypeId,
    this.selectedTime,
    this.insurancePictureStatus = Status.initial,
    this.insurancePicture,
    this.insurancePictureName,
    this.addReminderStatus = Status.initial,
    this.addReminderErrorMessage,
  });

  @override
  List<Object?> get props => [
        selectedTypeId,
        selectedTime,
        insurancePictureStatus,
        fetchAlarmTypesStatus,
        fetchAlarmTypesErrorMessage,
        alarmTypes,
        insurancePicture,
        insurancePictureName,
        addReminderStatus,
        addReminderErrorMessage,
      ];

  AddReminderState copyWith({
    Status? fetchAlarmTypesStatus,
    String? fetchAlarmTypesErrorMessage,
    List<AlarmTypesEntity>? alarmTypes,
    int? selectedTypeId,
    int? selectedTime,
    Status? insurancePictureStatus,
    File? insurancePicture,
    String? insurancePictureName,
    bool removePicture = false,
    Status? addReminderStatus,
    String? addReminderErrorMessage,
  }) {
    return AddReminderState(
      fetchAlarmTypesStatus:
          fetchAlarmTypesStatus ?? this.fetchAlarmTypesStatus,
      fetchAlarmTypesErrorMessage:
          fetchAlarmTypesErrorMessage ?? this.fetchAlarmTypesErrorMessage,
      alarmTypes: alarmTypes ?? this.alarmTypes,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      selectedTime: selectedTime ?? this.selectedTime,
      insurancePictureStatus:
          insurancePictureStatus ?? this.insurancePictureStatus,
      insurancePicture:
          removePicture ? null : insurancePicture ?? this.insurancePicture,
      insurancePictureName: removePicture
          ? null
          : insurancePictureName ?? this.insurancePictureName,
      addReminderStatus: addReminderStatus ?? this.addReminderStatus,
      addReminderErrorMessage:
          addReminderErrorMessage ?? this.addReminderErrorMessage,
    );
  }
}
