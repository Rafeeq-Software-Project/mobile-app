// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_founder_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateFounderProfileRequest _$UpdateFounderProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateFounderProfileRequest(
  companyName: json['companyName'] as String,
  industry: json['industry'] as String,
  websiteUrl: json['websiteUrl'] as String,
  phoneNumber: json['phoneNumber'] as String,
  roleTitle: json['roleTitle'] as String,
  bio: json['bio'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$UpdateFounderProfileRequestToJson(
  UpdateFounderProfileRequest instance,
) => <String, dynamic>{
  'companyName': instance.companyName,
  'industry': instance.industry,
  'websiteUrl': instance.websiteUrl,
  'phoneNumber': instance.phoneNumber,
  'roleTitle': instance.roleTitle,
  'bio': instance.bio,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};
