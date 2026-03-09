import 'package:json_annotation/json_annotation.dart';

part 'update_investor_profile_response.g.dart';

@JsonSerializable()
class UpdateInvestorProfileResponse {
  final int id;
  final int userId;
  final String investorType;
  final String location;
  final int minInvestment;
  final int maxInvestment;
  final String stage;
  final String investmentInterests;
  final String bio;
  final int experienceYears;
  final String createdAt;
  final String updatedAt;
  final String userEmail;
  final String userFirstName;
  final String userLastName;
  final String? userProfilePictureUrl;

  UpdateInvestorProfileResponse({
    required this.id,
    required this.userId,
    required this.investorType,
    required this.location,
    required this.minInvestment,
    required this.maxInvestment,
    required this.stage,
    required this.investmentInterests,
    required this.bio,
    required this.experienceYears,
    required this.createdAt,
    required this.updatedAt,
    required this.userEmail,
    required this.userFirstName,
    required this.userLastName,
    this.userProfilePictureUrl,
  });

  factory UpdateInvestorProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateInvestorProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInvestorProfileResponseToJson(this);
}
