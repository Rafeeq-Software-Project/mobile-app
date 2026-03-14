// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_investor_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInvestorProfileRequest _$UpdateInvestorProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateInvestorProfileRequest(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  investorType: json['investorType'] as String,
  location: json['location'] as String,
  minInvestment: (json['minInvestment'] as num).toDouble(),
  maxInvestment: (json['maxInvestment'] as num).toDouble(),
  stage: json['stage'] as String,
  investmentInterests: json['investmentInterests'] as String,
  bio: json['bio'] as String,
  experienceYears: (json['experienceYears'] as num).toInt(),
);

Map<String, dynamic> _$UpdateInvestorProfileRequestToJson(
  UpdateInvestorProfileRequest instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'investorType': instance.investorType,
  'location': instance.location,
  'minInvestment': instance.minInvestment,
  'maxInvestment': instance.maxInvestment,
  'stage': instance.stage,
  'investmentInterests': instance.investmentInterests,
  'bio': instance.bio,
  'experienceYears': instance.experienceYears,
};
