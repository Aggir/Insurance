part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final Status changePasswordStatus;
  final String? changePasswordError;
  const ChangePasswordState({
    this.changePasswordStatus = Status.initial,
    this.changePasswordError,
  });

  @override
  List<Object?> get props {
    return [
      changePasswordStatus,
      changePasswordError,
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
    );
  }
}
