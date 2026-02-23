import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/founder_profile/data/models/founder_profile.dart';
part 'founder_profile_state.freezed.dart';

@freezed
class FounderProfileState with _$FounderProfileState {
  const factory FounderProfileState.initial() = _Initial;
  const factory FounderProfileState.loading() = Loading;
  const factory FounderProfileState.loaded({required FounderProfile profile}) =
      Loaded;
  const factory FounderProfileState.error({required String message}) = Error;
}
