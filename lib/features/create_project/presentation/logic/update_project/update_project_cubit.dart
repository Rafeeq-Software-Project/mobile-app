import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/create_project/data/models/create_project_request.dart';
import 'package:rafeeq_app/features/create_project/data/repos/update_project_repo.dart';
import 'update_project_state.dart';

class UpdateProjectCubit extends Cubit<UpdateProjectState> {
  final UpdateProjectRepo repo;

  UpdateProjectCubit(this.repo) : super(const UpdateProjectState.initial());

  Future<void> updateProject(
    int projectId,
    CreateProjectRequest request,
  ) async {
    emit(const UpdateProjectState.loading());

    final result = await repo.updateProject(projectId, request);

    result.when(
      success: (project) {
        emit(UpdateProjectState.success(project));
      },
      failure: (error) {
        emit(UpdateProjectState.error(error.toString()));
      },
    );
  }
}
