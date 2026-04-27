import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/pending_draft_model.dart';
part 'draft_details_state.freezed.dart';

@freezed
class DraftDetailsState with _$DraftDetailsState {
  const factory DraftDetailsState.initial() = _Initial;

  const factory DraftDetailsState.loading() = _Loading;

  const factory DraftDetailsState.success(PendingDraftModel draft) = _Success;

  const factory DraftDetailsState.error(String message) = _Error;
}
