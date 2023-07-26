part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.fetchAccount = Status.initial,
    this.fetchAccountError,
    this.isEditing = false,
    required this.isLibyan,
    this.editStatus = Status.initial,
    this.editError,
  });
  final Status fetchAccount;
  final String? fetchAccountError;
  final bool isEditing;

  final bool? isLibyan;
  final Status editStatus;
  final String? editError;

  @override
  List<Object?> get props => [
        fetchAccount,
        fetchAccountError,
        isEditing,
        editStatus,
        editError,
        isLibyan,
      ];

  ProfileState copyWith({
    Status? fetchAccount,
    String? fetchAccountError,
    bool? isEditing,
    bool? isLibyan,
    Status? editStatus,
    String? editError,
  }) {
    return ProfileState(
      fetchAccount: fetchAccount ?? this.fetchAccount,
      fetchAccountError: fetchAccountError ?? this.fetchAccountError,
      isEditing: isEditing ?? this.isEditing,
      isLibyan: isLibyan ?? this.isLibyan,
      editStatus: editStatus ?? this.editStatus,
      editError: editError ?? this.editError,
    );
  }
}
