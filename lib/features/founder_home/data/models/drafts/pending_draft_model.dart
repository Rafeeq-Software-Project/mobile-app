import 'package:json_annotation/json_annotation.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/live_project.dart';

part 'pending_draft_model.g.dart';

@JsonSerializable()
class PendingDraftModel {
  final int id;
  final int projectId;
  final int founderId;
  final String name;
  final String description;
  final String category;
  final double fundingGoal;
  final String useOfFunds;
  final String startDate;
  final String endDate;
  final String status;
  final String createdAt;
  final String? updatedAt;
  final String? reviewedByRole;
  final int? reviewedByUserId;
  final String? reviewedAt;
  final String? rejectionReason;
  final String founderName;
  final String? founderCompany;
  final LiveProject? liveProject;

  PendingDraftModel({
    required this.id,
    required this.projectId,
    required this.founderId,
    required this.name,
    required this.description,
    required this.category,
    required this.fundingGoal,
    required this.useOfFunds,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.reviewedByRole,
    this.reviewedByUserId,
    this.reviewedAt,
    this.rejectionReason,
    required this.founderName,
    this.founderCompany,
    this.liveProject,
  });

  factory PendingDraftModel.fromJson(Map<String, dynamic> json) =>
      _$PendingDraftModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingDraftModelToJson(this);
}
