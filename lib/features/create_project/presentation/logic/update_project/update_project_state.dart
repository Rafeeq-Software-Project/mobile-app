import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/create_project/data/models/update_project_response.dart';
part 'update_project_state.freezed.dart';

@freezed
class UpdateProjectState with _$UpdateProjectState {
  const factory UpdateProjectState.initial() = _Initial;

  const factory UpdateProjectState.loading() = _Loading;

  const factory UpdateProjectState.success(UpdateProjectResponse project) =
      _Success;

  const factory UpdateProjectState.error(String message) = _Error;
}
