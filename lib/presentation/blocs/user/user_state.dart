part of 'user_cubit.dart';

class UserState extends Equatable {
  final UserEntity? user;
  final Status authStatus;
  final String? authErrorMessage;
  final Status checkTokenStatus;
  final String? checkTokenErrorMessage;
  final Status logoutStatus;
  final String? logoutErrorMessage;

  const UserState({
    this.user,
    this.authStatus = Status.initial,
    this.authErrorMessage,
    this.checkTokenStatus = Status.initial,
    this.checkTokenErrorMessage,
    this.logoutStatus = Status.initial,
    this.logoutErrorMessage,
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
      ];

  UserState copyWith({
    UserEntity? user,
    Status? authStatus,
    String? authErrorMessage,
    Status? checkTokenStatus,
    String? checkTokenErrorMessage,
    Status? logoutStatus,
    String? logoutErrorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
      checkTokenStatus: checkTokenStatus ?? this.checkTokenStatus,
      checkTokenErrorMessage:
          checkTokenErrorMessage ?? this.checkTokenErrorMessage,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      logoutErrorMessage: logoutErrorMessage ?? this.logoutErrorMessage,
    );
  }
}
