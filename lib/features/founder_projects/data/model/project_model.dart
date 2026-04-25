import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel {
  final int id;
  final int founderId;
  final String name;
  final String description;
  final String category;
  final String status;
  @JsonKey(fromJson: _toDouble)
  final double fundingGoal;
  final String useOfFunds;

  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;

  final DateTime? updatedAt;
  final String? reviewedByRole;
  final int? reviewedByUserId;
  final DateTime? reviewedAt;
  final String? rejectionReason;

  final String founderName;
  final String? founderCompany;
  final String? founderProfilePicture;

  ProjectModel({
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

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}

double _toDouble(dynamic value) => (value as num).toDouble();
