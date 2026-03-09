import 'package:json_annotation/json_annotation.dart';

part 'update_founder_profile_request.g.dart';

@JsonSerializable()
class UpdateFounderProfileRequest {
  final String companyName;
  final String industry;
  final String websiteUrl;
  final String phoneNumber;
  final String roleTitle;
  final String bio;
  final String firstName;
  final String lastName;

  UpdateFounderProfileRequest({
    required this.companyName,
    required this.industry,
    required this.websiteUrl,
    required this.phoneNumber,
    required this.roleTitle,
    required this.bio,
    required this.firstName,
    required this.lastName,
  });

  factory UpdateFounderProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateFounderProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateFounderProfileRequestToJson(this);
}
