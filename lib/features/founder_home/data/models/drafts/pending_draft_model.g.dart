// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_draft_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingDraftModel _$PendingDraftModelFromJson(Map<String, dynamic> json) =>
    PendingDraftModel(
      id: (json['id'] as num).toInt(),
      projectId: (json['projectId'] as num).toInt(),
      founderId: (json['founderId'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      fundingGoal: (json['fundingGoal'] as num).toDouble(),
      useOfFunds: json['useOfFunds'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      reviewedByRole: json['reviewedByRole'] as String?,
      reviewedByUserId: (json['reviewedByUserId'] as num?)?.toInt(),
      reviewedAt: json['reviewedAt'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      founderName: json['founderName'] as String,
      founderCompany: json['founderCompany'] as String?,
      liveProject: json['liveProject'] == null
          ? null
          : LiveProject.fromJson(json['liveProject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PendingDraftModelToJson(PendingDraftModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'founderId': instance.founderId,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'fundingGoal': instance.fundingGoal,
      'useOfFunds': instance.useOfFunds,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'reviewedByRole': instance.reviewedByRole,
      'reviewedByUserId': instance.reviewedByUserId,
      'reviewedAt': instance.reviewedAt,
      'rejectionReason': instance.rejectionReason,
      'founderName': instance.founderName,
      'founderCompany': instance.founderCompany,
      'liveProject': instance.liveProject,
    };
