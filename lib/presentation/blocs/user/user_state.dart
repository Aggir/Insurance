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
  final bool isFirstLogin;
  final Status confirmEmailStatus;
  final String? confirmEmailErrorMessage;
  final Status refreshUserDataStatus;
  final String? refreshUserDataErrorMessage;

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
    this.isFirstLogin = false,
    this.confirmEmailStatus = Status.initial,
    this.confirmEmailErrorMessage,
    this.refreshUserDataStatus = Status.initial,
    this.refreshUserDataErrorMessage,
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
        isFirstLogin,
        confirmEmailStatus,
        confirmEmailErrorMessage,
        refreshUserDataStatus,
        refreshUserDataErrorMessage,
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
    bool? isFirstLogin,
    Status? confirmEmailStatus,
    String? confirmEmailErrorMessage,
    Status? refreshUserDataStatus,
    String? refreshUserDataErrorMessage,
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
      isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      confirmEmailStatus: confirmEmailStatus ?? this.confirmEmailStatus,
      confirmEmailErrorMessage:
          confirmEmailErrorMessage ?? this.confirmEmailErrorMessage,
      refreshUserDataStatus:
          refreshUserDataStatus ?? this.refreshUserDataStatus,
      refreshUserDataErrorMessage:
          refreshUserDataErrorMessage ?? this.refreshUserDataErrorMessage,
    );
  }

  @override
  String toString() {
    return 'UserState(user: ${user != null}, authStatus: $authStatus, authErrorMessage: $authErrorMessage, checkTokenStatus: $checkTokenStatus, checkTokenErrorMessage: $checkTokenErrorMessage, logoutStatus: $logoutStatus, logoutErrorMessage: $logoutErrorMessage, editProfileStatus: $editProfileStatus, editProfileErrorMessage: $editProfileErrorMessage, deactivateStatus: $deactivateStatus, deactivateErrorMessage: $deactivateErrorMessage, isFirstLogin: $isFirstLogin, confirmEmailStatus: $confirmEmailStatus, confirmEmailErrorMessage: $confirmEmailErrorMessage, refreshUserDataStatus: $refreshUserDataStatus, refreshUserDataErrorMessage: $refreshUserDataErrorMessage)';
  }
}
