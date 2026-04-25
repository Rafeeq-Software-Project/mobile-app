import 'package:json_annotation/json_annotation.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
part 'update_project_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateProjectResponse {
  final String mode;
  final String message;
  final ProjectDraftModel? draft;
  final ProjectModel? project;

  UpdateProjectResponse({
    required this.mode,
    required this.message,
    this.draft,
    this.project,
  });

  factory UpdateProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProjectResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProjectDraftModel {
  final int id;
  final int projectId;
  final String? category;
  @JsonKey(fromJson: _toDoubleNullable)
  final double? fundingGoal;
  final String? useOfFunds;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
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
    this.category,
    this.fundingGoal,
    this.useOfFunds,
    this.startDate,
    this.endDate,
    this.status,
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

double? _toDoubleNullable(dynamic value) {
  if (value == null) return null;
  return (value as num).toDouble();
}
