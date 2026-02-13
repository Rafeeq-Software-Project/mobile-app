// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestModel _$ResetPasswordRequestModelFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestModel(
  resetToken: json['resetToken'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestModelToJson(
  ResetPasswordRequestModel instance,
) => <String, dynamic>{
  'resetToken': instance.resetToken,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};
