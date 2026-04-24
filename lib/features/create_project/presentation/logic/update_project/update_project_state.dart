import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';

part 'update_project_state.freezed.dart';

@freezed
class UpdateProjectState with _$UpdateProjectState {
  const factory UpdateProjectState.initial() = _Initial;

  const factory UpdateProjectState.loading() = _Loading;

  const factory UpdateProjectState.success(ProjectModel project) = _Success;

  const factory UpdateProjectState.error(String message) = _Error;
}
