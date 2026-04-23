import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';

part 'get_projects_state.freezed.dart';

@freezed
class GetProjectsState with _$GetProjectsState {
  const factory GetProjectsState.initial() = _Initial;

  const factory GetProjectsState.loading() = _Loading;

  const factory GetProjectsState.success(List<ProjectModel> projects) =
      _Success;

  const factory GetProjectsState.error(String message) = _Error;
}
