// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
  Map<String, dynamic> json,
) => RegisterResponseModel(
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

Map<String, dynamic> _$RegisterResponseModelToJson(
  RegisterResponseModel instance,
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
