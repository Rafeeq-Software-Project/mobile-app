// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResponseModel _$RefreshTokenResponseModelFromJson(
  Map<String, dynamic> json,
) => RefreshTokenResponseModel(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  userId: (json['userId'] as num).toInt(),
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  username: json['username'] as String,
  profilePictureUrl: json['profilePictureUrl'] as String?,
  roleName: json['roleName'] as String,
  roleId: (json['roleId'] as num).toInt(),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$RefreshTokenResponseModelToJson(
  RefreshTokenResponseModel instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'userId': instance.userId,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'username': instance.username,
  'profilePictureUrl': instance.profilePictureUrl,
  'roleName': instance.roleName,
  'roleId': instance.roleId,
  'expiresAt': instance.expiresAt.toIso8601String(),
};
