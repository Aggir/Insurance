part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final Status changePasswordStatus;
  final String? changePasswordError;
  final String? currentPassword;
  final String? newPassword;
  const ChangePasswordState({
    this.changePasswordStatus = Status.initial,
    this.changePasswordError,
    this.currentPassword,
    this.newPassword,
  });

  @override
  List<Object?> get props {
    return [
      changePasswordStatus,
      changePasswordError,
      currentPassword,
      newPassword,
    ];
  }

  ChangePasswordState copyWith({
    Status? changePasswordStatus,
    String? changePasswordError,
    String? currentPassword,
    String? newPassword,
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      changePasswordError: changePasswordError ?? this.changePasswordError,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
