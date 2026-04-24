import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/create_project/data/repos/delete_project_repo.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/delete_project/delete_project_state.dart';

class DeleteProjectCubit extends Cubit<DeleteProjectState> {
  final DeleteProjectRepo repo;

  DeleteProjectCubit(this.repo) : super(const DeleteProjectState.initial());

  Future<void> deleteProject(int projectId) async {
    emit(const DeleteProjectState.loading());

    final result = await repo.deleteProject(projectId);

    result.when(
      success: (message) {
        emit(DeleteProjectState.success(message));
      },
      failure: (error) {
        emit(DeleteProjectState.error(error.toString()));
      },
    );
  }
}
