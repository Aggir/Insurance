part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.photoFile,
    this.isEditing = false,
    this.isLibyan,
    this.phoneCode,
    this.editStatus = Status.initial,
    this.editError,
  });

  final File? photoFile;
  final bool isEditing;
  final bool? isLibyan;
  final String? phoneCode;
  final Status editStatus;
  final String? editError;

  @override
  List<Object?> get props => [
        photoFile,
        isEditing,
        phoneCode,
        editStatus,
        editError,
        isLibyan,
      ];

  ProfileState copyWith({
    File? photoFile,
    bool? isEditing,
    String? phoneCode,
    bool? isLibyan,
    Status? editStatus,
    String? editError,
    bool removePickedPhoto = false,
  }) {
    return ProfileState(
      photoFile: removePickedPhoto ? null : photoFile ?? this.photoFile,
      isEditing: isEditing ?? this.isEditing,
      phoneCode: phoneCode ?? this.phoneCode,
      isLibyan: isLibyan ?? this.isLibyan,
      editStatus: editStatus ?? this.editStatus,
      editError: editError ?? this.editError,
    );
  }
}
