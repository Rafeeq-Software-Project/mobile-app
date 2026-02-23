// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'founder_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FounderProfile _$FounderProfileFromJson(Map<String, dynamic> json) =>
    FounderProfile(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      companyName: json['companyName'] as String?,
      industry: json['industry'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      roleTitle: json['roleTitle'] as String?,
      bio: json['bio'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      userEmail: json['userEmail'] as String,
      userFirstName: json['userFirstName'] as String,
      userLastName: json['userLastName'] as String,
      userProfilePictureUrl: json['userProfilePictureUrl'] as String?,
    );

Map<String, dynamic> _$FounderProfileToJson(FounderProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'companyName': instance.companyName,
      'industry': instance.industry,
      'websiteUrl': instance.websiteUrl,
      'phoneNumber': instance.phoneNumber,
      'roleTitle': instance.roleTitle,
      'bio': instance.bio,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'userEmail': instance.userEmail,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'userProfilePictureUrl': instance.userProfilePictureUrl,
    };
