import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response_model.g.dart';

@JsonSerializable()
class RefreshTokenResponseModel {
  final String accessToken;
  final String refreshToken;
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String? profilePictureUrl;
  final String roleName;
  final int roleId;
  final DateTime expiresAt;

  RefreshTokenResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.profilePictureUrl,
    required this.roleName,
    required this.roleId,
    required this.expiresAt,
  });

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseModelToJson(this);
}
