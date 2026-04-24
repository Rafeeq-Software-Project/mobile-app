import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';

part 'create_project_state.freezed.dart';

@freezed
class CreateProjectState with _$CreateProjectState {
  const factory CreateProjectState.initial() = _Initial;

  const factory CreateProjectState.loading() = _Loading;

  const factory CreateProjectState.success(ProjectModel project) = _Success;

  const factory CreateProjectState.error(String message) = _Error;
}
