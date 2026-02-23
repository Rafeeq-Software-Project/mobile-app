part of 'current_user.dart';

class _UserLocalData {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String? profilePictureUrl;
  final String roleName;
  final int roleId;
  final DateTime expiresAt;

  const _UserLocalData({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.profilePictureUrl,
    required this.roleName,
    required this.roleId,
    required this.expiresAt,
  });
}
