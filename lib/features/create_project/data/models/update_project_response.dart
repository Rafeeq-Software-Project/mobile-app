import 'package:json_annotation/json_annotation.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';

part 'update_project_response.g.dart';

@JsonSerializable()
class UpdateProjectResponse {
  final String mode;
  final String message;
  final ProjectDraftModel draft;

  UpdateProjectResponse({
    required this.mode,
    required this.message,
    required this.draft,
  });

  factory UpdateProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProjectResponseToJson(this);
}

@JsonSerializable()
class ProjectDraftModel {
  final int id;
  final int projectId;
  final String category;
  final double fundingGoal;
  final String useOfFunds;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;

  final DateTime? updatedAt;
  final String? reviewedByRole;
  final int? reviewedByUserId;
  final DateTime? reviewedAt;
  final String? rejectionReason;

  final String founderName;
  final String? founderCompany;

  final ProjectModel liveProject;

  ProjectDraftModel({
    required this.id,
    required this.projectId,
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
    required this.liveProject,
  });

  factory ProjectDraftModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectDraftModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDraftModelToJson(this);
}
