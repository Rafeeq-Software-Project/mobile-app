import 'package:json_annotation/json_annotation.dart';

part 'update_founder_profile_response.g.dart';

@JsonSerializable()
class UpdateFounderProfileResponse {
  final int id;
  final int userId;
  final String companyName;
  final String industry;
  final String websiteUrl;
  final String phoneNumber;
  final String roleTitle;
  final String bio;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userEmail;
  final String userFirstName;
  final String userLastName;
  final String? userProfilePictureUrl;

  UpdateFounderProfileResponse({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.industry,
    required this.websiteUrl,
    required this.phoneNumber,
    required this.roleTitle,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
    required this.userEmail,
    required this.userFirstName,
    required this.userLastName,
    this.userProfilePictureUrl,
  });

  factory UpdateFounderProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateFounderProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateFounderProfileResponseToJson(this);
}
