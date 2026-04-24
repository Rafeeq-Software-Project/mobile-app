// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_project_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProjectRequest _$CreateProjectRequestFromJson(
  Map<String, dynamic> json,
) => CreateProjectRequest(
  name: json['name'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  fundingGoal: (json['fundingGoal'] as num).toDouble(),
  useOfFunds: json['useOfFunds'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
);

Map<String, dynamic> _$CreateProjectRequestToJson(
  CreateProjectRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'category': instance.category,
  'fundingGoal': instance.fundingGoal,
  'useOfFunds': instance.useOfFunds,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
};
