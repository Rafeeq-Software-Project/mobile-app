import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
part 'project_details_state.freezed.dart';

@freezed
class ProjectDetailsState with _$ProjectDetailsState {
  const factory ProjectDetailsState.initial() = _Initial;

  const factory ProjectDetailsState.loading() = _Loading;

  const factory ProjectDetailsState.success(ProjectModel project) = _Success;

  const factory ProjectDetailsState.error(String message) = _Error;
}
