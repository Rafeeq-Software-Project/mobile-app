import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/investor_account/data/models/update_investor_profile/update_investor_profile_response.dart';
part 'update_investor_profile_state.freezed.dart';

@freezed
class UpdateInvestorProfileState with _$UpdateInvestorProfileState {
  const factory UpdateInvestorProfileState.initial() = _Initial;

  const factory UpdateInvestorProfileState.loading() = _Loading;

  const factory UpdateInvestorProfileState.success(
    UpdateInvestorProfileResponse response,
  ) = _Success;

  const factory UpdateInvestorProfileState.error(String message) = _Error;
}
