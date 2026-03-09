// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_investor_profile_picture_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadInvestorProfilePictureResponse
_$UploadInvestorProfilePictureResponseFromJson(Map<String, dynamic> json) =>
    UploadInvestorProfilePictureResponse(
      message: json['message'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String,
    );

Map<String, dynamic> _$UploadInvestorProfilePictureResponseToJson(
  UploadInvestorProfilePictureResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'profilePictureUrl': instance.profilePictureUrl,
};
