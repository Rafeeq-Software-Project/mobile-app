import 'package:json_annotation/json_annotation.dart';
part 'investor_profile_model.g.dart';

@JsonSerializable()
class InvestorProfileModel {
  final int id;
  final int userId;
  final String? investorType;
  final String? location;
  final double? minInvestment;
  final double? maxInvestment;
  final String? stage;

  @JsonKey(fromJson: _interestsFromJson)
  final List<String>? investmentInterests;

  final String? bio;
  final int? experienceYears;
  final String createdAt;
  final String? updatedAt;
  final String userEmail;
  final String userFirstName;
  final String userLastName;
  final String? userProfilePictureUrl;

  InvestorProfileModel({
    required this.id,
    required this.userId,
    this.investorType,
    this.location,
    this.minInvestment,
    this.maxInvestment,
    this.stage,
    this.investmentInterests,
    this.bio,
    this.experienceYears,
    required this.createdAt,
    this.updatedAt,
    required this.userEmail,
    required this.userFirstName,
    required this.userLastName,
    this.userProfilePictureUrl,
  });

  factory InvestorProfileModel.fromJson(Map<String, dynamic> json) =>
      _$InvestorProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvestorProfileModelToJson(this);

  static List<String>? _interestsFromJson(dynamic value) {
    if (value == null) return [];

    if (value is String) {
      return value.split(',');
    }

    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }

    return [];
  }
}
