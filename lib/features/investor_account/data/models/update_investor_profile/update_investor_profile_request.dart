import 'package:json_annotation/json_annotation.dart';

part 'update_investor_profile_request.g.dart';

@JsonSerializable()
class UpdateInvestorProfileRequest {
  final String firstName;
  final String lastName;
  final String investorType;
  final String location;
  final int minInvestment;
  final int maxInvestment;
  final String stage;
  final String investmentInterests;
  final String bio;
  final int experienceYears;

  UpdateInvestorProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.investorType,
    required this.location,
    required this.minInvestment,
    required this.maxInvestment,
    required this.stage,
    required this.investmentInterests,
    required this.bio,
    required this.experienceYears,
  });

  factory UpdateInvestorProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateInvestorProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInvestorProfileRequestToJson(this);
}
