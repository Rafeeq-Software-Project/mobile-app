import 'package:json_annotation/json_annotation.dart';

part 'founder_profile.g.dart';

@JsonSerializable()
class FounderProfile {
  final int id;
  final int userId;
  final String? companyName;
  final String? industry;
  final String? websiteUrl;
  final String? phoneNumber;
  final String? roleTitle;
  final String? bio;
  final String createdAt;
  final String? updatedAt;
  final String userEmail;
  final String userFirstName;
  final String userLastName;
  final String? userProfilePictureUrl;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String fullName;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isProfileComplete;

  FounderProfile({
    required this.id,
    required this.userId,
    this.companyName,
    this.industry,
    this.websiteUrl,
    this.phoneNumber,
    this.roleTitle,
    this.bio,
    required this.createdAt,
    this.updatedAt,
    required this.userEmail,
    required this.userFirstName,
    required this.userLastName,
    this.userProfilePictureUrl,
  }) : fullName = "$userFirstName $userLastName",
       isProfileComplete =
           companyName != null || bio != null || websiteUrl != null;

  factory FounderProfile.fromJson(Map<String, dynamic> json) =>
      _$FounderProfileFromJson(json);
  Map<String, dynamic> toJson() => _$FounderProfileToJson(this);
}
