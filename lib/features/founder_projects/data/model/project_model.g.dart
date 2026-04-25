// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
  id: (json['id'] as num).toInt(),
  founderId: (json['founderId'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  status: json['status'] as String,
  fundingGoal: _toDouble(json['fundingGoal']),
  useOfFunds: json['useOfFunds'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
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
  founderProfilePicture: json['founderProfilePicture'] as String?,
);

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'founderId': instance.founderId,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'status': instance.status,
      'fundingGoal': instance.fundingGoal,
      'useOfFunds': instance.useOfFunds,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'reviewedByRole': instance.reviewedByRole,
      'reviewedByUserId': instance.reviewedByUserId,
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'founderName': instance.founderName,
      'founderCompany': instance.founderCompany,
      'founderProfilePicture': instance.founderProfilePicture,
    };
