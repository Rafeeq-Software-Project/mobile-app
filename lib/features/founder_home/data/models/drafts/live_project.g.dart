// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveProject _$LiveProjectFromJson(Map<String, dynamic> json) => LiveProject(
  id: (json['id'] as num).toInt(),
  founderId: (json['founderId'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  status: json['status'] as String,
  fundingGoal: (json['fundingGoal'] as num).toDouble(),
  useOfFunds: json['useOfFunds'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
  reviewedByRole: json['reviewedByRole'] as String?,
  reviewedByUserId: (json['reviewedByUserId'] as num?)?.toInt(),
  reviewedAt: json['reviewedAt'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
  founderName: json['founderName'] as String,
  founderCompany: json['founderCompany'] as String?,
  founderProfilePicture: json['founderProfilePicture'] as String?,
);

Map<String, dynamic> _$LiveProjectToJson(LiveProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'founderId': instance.founderId,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'status': instance.status,
      'fundingGoal': instance.fundingGoal,
      'useOfFunds': instance.useOfFunds,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'reviewedByRole': instance.reviewedByRole,
      'reviewedByUserId': instance.reviewedByUserId,
      'reviewedAt': instance.reviewedAt,
      'rejectionReason': instance.rejectionReason,
      'founderName': instance.founderName,
      'founderCompany': instance.founderCompany,
      'founderProfilePicture': instance.founderProfilePicture,
    };
