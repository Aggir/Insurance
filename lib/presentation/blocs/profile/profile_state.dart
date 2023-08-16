part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.photoFile,
    this.isEditing = false,
    this.isLibyan,
    this.editStatus = Status.initial,
    this.editError,
  });

  final File? photoFile;
  final bool isEditing;
  final bool? isLibyan;
  final Status editStatus;
  final String? editError;

  @override
  List<Object?> get props => [
        photoFile,
        isEditing,
        editStatus,
        editError,
        isLibyan,
      ];

  ProfileState copyWith({
    File? photoFile,
    bool? isEditing,
    bool? isLibyan,
    Status? editStatus,
    String? editError,
    bool removePickedPhoto = false,
  }) {
    return ProfileState(
      photoFile: removePickedPhoto ? null : photoFile ?? this.photoFile,
      isEditing: isEditing ?? this.isEditing,
      isLibyan: isLibyan ?? this.isLibyan,
      editStatus: editStatus ?? this.editStatus,
      editError: editError ?? this.editError,
    );
  }
}
