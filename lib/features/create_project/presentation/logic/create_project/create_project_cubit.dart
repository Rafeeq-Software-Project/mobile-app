import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/create_project/data/models/create_project_request.dart';
import 'package:rafeeq_app/features/create_project/data/repos/create_project_repo.dart';
import 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  final CreateProjectRepo repo;

  CreateProjectCubit(this.repo) : super(const CreateProjectState.initial());

  Future<void> createProject(CreateProjectRequest request) async {
    emit(const CreateProjectState.loading());

    final result = await repo.createProject(request);

    result.when(
      success: (project) {
        emit(CreateProjectState.success(project));
      },
      failure: (error) {
        emit(CreateProjectState.error(error.toString()));
      },
    );
  }
}
