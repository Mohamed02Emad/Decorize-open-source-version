part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  final RequestState<User> updateProfileState;
  final String name;
  final String email;
  final String phone;
  final String password;
  final File? profileImage;
  final String? profileImageUrl;
  final bool isInitialized;

  // Original values for comparison
  final String originalName;
  final String originalEmail;
  final String originalPhone;
  final String? originalProfileImageUrl;

  UpdateProfileState.initial()
      : updateProfileState = RequestState.initial(),
        name = '',
        email = '',
        phone = '',
        password = '**********',
        profileImage = null,
        profileImageUrl = null,
        isInitialized = false,
        originalName = '',
        originalEmail = '',
        originalPhone = '',
        originalProfileImageUrl = null;

  const UpdateProfileState({
    required this.updateProfileState,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.profileImage,
    this.profileImageUrl,
    required this.isInitialized,
    required this.originalName,
    required this.originalEmail,
    required this.originalPhone,
    this.originalProfileImageUrl,
  });

  UpdateProfileState copyWith({
    RequestState<User>? updateProfileState,
    String? name,
    String? email,
    String? phone,
    String? password,
    File? profileImage,
    String? profileImageUrl,
    bool? isInitialized,
    String? originalName,
    String? originalEmail,
    String? originalPhone,
    String? originalProfileImageUrl,
  }) {
    return UpdateProfileState(
      updateProfileState: updateProfileState ?? this.updateProfileState,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isInitialized: isInitialized ?? this.isInitialized,
      originalName: originalName ?? this.originalName,
      originalEmail: originalEmail ?? this.originalEmail,
      originalPhone: originalPhone ?? this.originalPhone,
      originalProfileImageUrl:
          originalProfileImageUrl ?? this.originalProfileImageUrl,
    );
  }

  bool get hasChanges {
    return name != originalName ||
        email != originalEmail ||
        phone != originalPhone ||
        profileImage != null ||
        (password != '**********' && password.isNotEmpty);
  }

  @override
  List<Object?> get props => [
        updateProfileState,
        name,
        email,
        phone,
        password,
        profileImage,
        profileImageUrl,
        isInitialized,
        originalName,
        originalEmail,
        originalPhone,
        originalProfileImageUrl,
      ];
}
