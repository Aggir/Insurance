part of 'user_cubit.dart';

class UserState extends Equatable {
  final UserEntity? user;
  final Status authStatus;
  final String? authErrorMessage;
  final Status checkTokenStatus;
  final String? checkTokenErrorMessage;
  final Status logoutStatus;
  final String? logoutErrorMessage;
  final Status editProfileStatus;
  final String? editProfileErrorMessage;
  final Status deactivateStatus;
  final String? deactivateErrorMessage;

  const UserState({
    this.user,
    this.authStatus = Status.initial,
    this.authErrorMessage,
    this.checkTokenStatus = Status.initial,
    this.checkTokenErrorMessage,
    this.logoutStatus = Status.initial,
    this.logoutErrorMessage,
    this.editProfileStatus = Status.initial,
    this.editProfileErrorMessage,
    this.deactivateStatus = Status.initial,
    this.deactivateErrorMessage,
  });

  @override
  List<Object?> get props => [
        user,
        authStatus,
        authErrorMessage,
        checkTokenStatus,
        checkTokenErrorMessage,
        logoutStatus,
        logoutErrorMessage,
        editProfileStatus,
        editProfileErrorMessage,
        deactivateStatus,
        deactivateErrorMessage,
      ];

  UserState copyWith({
    UserEntity? user,
    Status? authStatus,
    String? authErrorMessage,
    Status? checkTokenStatus,
    String? checkTokenErrorMessage,
    Status? logoutStatus,
    String? logoutErrorMessage,
    Status? editProfileStatus,
    String? editProfileErrorMessage,
    Status? deactivateStatus,
    String? deactivateErrorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      deactivateStatus: deactivateStatus ?? this.deactivateStatus,
      deactivateErrorMessage:
          deactivateErrorMessage ?? this.deactivateErrorMessage,
      authStatus: authStatus ?? this.authStatus,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
      checkTokenStatus: checkTokenStatus ?? this.checkTokenStatus,
      checkTokenErrorMessage:
          checkTokenErrorMessage ?? this.checkTokenErrorMessage,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      logoutErrorMessage: logoutErrorMessage ?? this.logoutErrorMessage,
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      editProfileErrorMessage:
          editProfileErrorMessage ?? this.editProfileErrorMessage,
    );
  }
}
