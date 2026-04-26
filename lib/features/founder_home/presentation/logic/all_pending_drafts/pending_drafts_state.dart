import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/pending_draft_model.dart';

part 'pending_drafts_state.freezed.dart';

@freezed
class PendingDraftsState with _$PendingDraftsState {
  const factory PendingDraftsState.initial() = _Initial;

  const factory PendingDraftsState.loading() = _Loading;

  const factory PendingDraftsState.success(List<PendingDraftModel> drafts) =
      _Success;

  const factory PendingDraftsState.error(String message) = _Error;
}
