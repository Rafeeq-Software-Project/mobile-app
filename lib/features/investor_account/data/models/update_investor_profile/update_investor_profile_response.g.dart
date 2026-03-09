// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_investor_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInvestorProfileResponse _$UpdateInvestorProfileResponseFromJson(
  Map<String, dynamic> json,
) => UpdateInvestorProfileResponse(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  investorType: json['investorType'] as String,
  location: json['location'] as String,
  minInvestment: (json['minInvestment'] as num).toInt(),
  maxInvestment: (json['maxInvestment'] as num).toInt(),
  stage: json['stage'] as String,
  investmentInterests: json['investmentInterests'] as String,
  bio: json['bio'] as String,
  experienceYears: (json['experienceYears'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  userEmail: json['userEmail'] as String,
  userFirstName: json['userFirstName'] as String,
  userLastName: json['userLastName'] as String,
  userProfilePictureUrl: json['userProfilePictureUrl'] as String?,
);

Map<String, dynamic> _$UpdateInvestorProfileResponseToJson(
  UpdateInvestorProfileResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'investorType': instance.investorType,
  'location': instance.location,
  'minInvestment': instance.minInvestment,
  'maxInvestment': instance.maxInvestment,
  'stage': instance.stage,
  'investmentInterests': instance.investmentInterests,
  'bio': instance.bio,
  'experienceYears': instance.experienceYears,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'userEmail': instance.userEmail,
  'userFirstName': instance.userFirstName,
  'userLastName': instance.userLastName,
  'userProfilePictureUrl': instance.userProfilePictureUrl,
};
