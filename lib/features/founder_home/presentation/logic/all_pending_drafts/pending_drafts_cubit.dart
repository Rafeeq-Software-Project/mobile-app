import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/founder_home/data/repos/get_all_pending_drafts_repo.dart';
import 'pending_drafts_state.dart';

class PendingDraftsCubit extends Cubit<PendingDraftsState> {
  final GetAllPendingDraftsRepo repo;

  PendingDraftsCubit(this.repo) : super(const PendingDraftsState.initial());

  Future<void> getAllPendingDrafts() async {
    emit(const PendingDraftsState.loading());
    final result = await repo.getAllPendingDrafts();
    result.when(
      success: (data) {
        if (isClosed) return;
        emit(PendingDraftsState.success(data));
      },
      failure: (error) {
        emit(PendingDraftsState.error(error.toString()));
      },
    );
  }
}
