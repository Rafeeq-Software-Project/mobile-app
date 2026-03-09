import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/core/network/network_failure.dart';
import 'package:rafeeq_app/features/founder_account/data/models/update_founder_profile/update_founder_profile_response.dart';
part 'update_founder_profile_state.freezed.dart';

@freezed
class UpdateFounderProfileState with _$UpdateFounderProfileState {
  const factory UpdateFounderProfileState.initial() = _Initial;
  const factory UpdateFounderProfileState.loading() = Loading;
  const factory UpdateFounderProfileState.loaded(
    UpdateFounderProfileResponse response,
  ) = Loaded;
  const factory UpdateFounderProfileState.error(NetworkFailure error) = Error;
}
