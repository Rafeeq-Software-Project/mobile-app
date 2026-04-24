// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProjectResponse _$UpdateProjectResponseFromJson(
  Map<String, dynamic> json,
) => UpdateProjectResponse(
  mode: json['mode'] as String,
  message: json['message'] as String,
  draft: ProjectDraftModel.fromJson(json['draft'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateProjectResponseToJson(
  UpdateProjectResponse instance,
) => <String, dynamic>{
  'mode': instance.mode,
  'message': instance.message,
  'draft': instance.draft,
};

ProjectDraftModel _$ProjectDraftModelFromJson(Map<String, dynamic> json) =>
    ProjectDraftModel(
      id: (json['id'] as num).toInt(),
      projectId: (json['projectId'] as num).toInt(),
      category: json['category'] as String,
      fundingGoal: (json['fundingGoal'] as num).toDouble(),
      useOfFunds: json['useOfFunds'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      reviewedByRole: json['reviewedByRole'] as String?,
      reviewedByUserId: (json['reviewedByUserId'] as num?)?.toInt(),
      reviewedAt: json['reviewedAt'] == null
          ? null
          : DateTime.parse(json['reviewedAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
      founderName: json['founderName'] as String,
      founderCompany: json['founderCompany'] as String?,
      liveProject: ProjectModel.fromJson(
        json['liveProject'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ProjectDraftModelToJson(ProjectDraftModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'category': instance.category,
      'fundingGoal': instance.fundingGoal,
      'useOfFunds': instance.useOfFunds,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'reviewedByRole': instance.reviewedByRole,
      'reviewedByUserId': instance.reviewedByUserId,
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'founderName': instance.founderName,
      'founderCompany': instance.founderCompany,
      'liveProject': instance.liveProject,
    };
