// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
  Map<String, dynamic> json,
) => RegisterRequestModel(
  email: json['email'] as String,
  password: json['password'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  username: json['username'] as String,
  roleId: (json['roleId'] as num).toInt(),
);

Map<String, dynamic> _$RegisterRequestModelToJson(
  RegisterRequestModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'username': instance.username,
  'roleId': instance.roleId,
};
