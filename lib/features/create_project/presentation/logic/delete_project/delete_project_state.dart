import 'package:freezed_annotation/freezed_annotation.dart';
part 'delete_project_state.freezed.dart';

@freezed
class DeleteProjectState with _$DeleteProjectState {
  const factory DeleteProjectState.initial() = _Initial;

  const factory DeleteProjectState.loading() = _Loading;

  const factory DeleteProjectState.success(String message) = _Success;

  const factory DeleteProjectState.error(String message) = _Error;
}
