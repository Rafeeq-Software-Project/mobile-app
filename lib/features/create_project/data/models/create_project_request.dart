import 'package:json_annotation/json_annotation.dart';
part 'create_project_request.g.dart';

@JsonSerializable()
class CreateProjectRequest {
  final String name;
  final String description;
  final String category;
  final double fundingGoal;
  final String useOfFunds;
  final String startDate;
  final String endDate;

  CreateProjectRequest({
    required this.name,
    required this.description,
    required this.category,
    required this.fundingGoal,
    required this.useOfFunds,
    required this.startDate,
    required this.endDate,
  });

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProjectRequestToJson(this);
}
