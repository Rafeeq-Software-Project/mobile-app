import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/founder_projects/data/repos/get_projects_repo.dart';
import 'get_projects_state.dart';

class GetProjectsCubit extends Cubit<GetProjectsState> {
  final GetProjectsRepo repo;

  GetProjectsCubit(this.repo) : super(const GetProjectsState.initial());

  Future<void> getProjects() async {
    emit(const GetProjectsState.loading());

    final result = await repo.getProjects();

    result.when(
      success: (projects) {
        emit(GetProjectsState.success(projects));
      },
      failure: (error) {
        emit(GetProjectsState.error(error.toString()));
      },
    );
  }
}
