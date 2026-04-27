import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/founder_home/data/repos/get_details_draft_repo.dart';
import 'draft_details_state.dart';

class DraftDetailsCubit extends Cubit<DraftDetailsState> {
  final GetDetailsDraftRepo repo;

  DraftDetailsCubit(this.repo) : super(const DraftDetailsState.initial());

  Future<void> getDraftDetails(int projectId) async {
    emit(const DraftDetailsState.loading());

    final result = await repo.getDetailsDraft(projectId);

    result.when(
      success: (data) {
        emit(DraftDetailsState.success(data));
      },
      failure: (error) {
        emit(DraftDetailsState.error(error.toString()));
      },
    );
  }
}
