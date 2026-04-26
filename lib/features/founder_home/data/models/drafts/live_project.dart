import 'package:json_annotation/json_annotation.dart';

part 'live_project.g.dart';

@JsonSerializable()
class LiveProject {
  final int id;
  final int founderId;
  final String name;
  final String description;
  final String category;
  final String status;
  final double fundingGoal;
  final String useOfFunds;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String? updatedAt;
  final String? reviewedByRole;
  final int? reviewedByUserId;
  final String? reviewedAt;
  final String? rejectionReason;
  final String founderName;
  final String? founderCompany;
  final String? founderProfilePicture;

  LiveProject({
    required this.id,
    required this.founderId,
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    required this.fundingGoal,
    required this.useOfFunds,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.updatedAt,
    this.reviewedByRole,
    this.reviewedByUserId,
    this.reviewedAt,
    this.rejectionReason,
    required this.founderName,
    this.founderCompany,
    this.founderProfilePicture,
  });

  factory LiveProject.fromJson(Map<String, dynamic> json) =>
      _$LiveProjectFromJson(json);

  Map<String, dynamic> toJson() => _$LiveProjectToJson(this);
}
