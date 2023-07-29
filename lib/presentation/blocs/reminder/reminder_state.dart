part of 'reminder_cubit.dart';

class ReminderState extends Equatable {
  final String? selectedType;
  final String? selectedTime;
  final Status insurancePictureStatus;
  const ReminderState({
    this.selectedType,
    this.selectedTime,
    this.insurancePictureStatus = Status.initial,
  });

  @override
  List<Object?> get props =>
      [selectedType, selectedTime, insurancePictureStatus];

  ReminderState copyWith({
    String? selectedType,
    String? selectedTime,
    Status? insurancePictureStatus,
  }) {
    return ReminderState(
      selectedType: selectedType ?? this.selectedType,
      selectedTime: selectedTime ?? this.selectedTime,
      insurancePictureStatus:
          insurancePictureStatus ?? this.insurancePictureStatus,
    );
  }
}
