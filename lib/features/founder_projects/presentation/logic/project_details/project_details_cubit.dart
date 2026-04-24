import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/repos/project_details_repo.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/project_details/project_details_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  final ProjectDetailsRepo repository;

  ProjectDetailsCubit(this.repository)
    : super(const ProjectDetailsState.initial());

  Future<void> getProject(int id) async {
    emit(const ProjectDetailsState.loading());

    final result = await repository.getProjectDetails(id);

    result.when(
      success: (project) {
        if (isClosed) return;
        emit(ProjectDetailsState.success(project));
      },
      failure: (error) {
        emit(ProjectDetailsState.error(error.toString()));
      },
    );
  }
}
