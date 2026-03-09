import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';
part 'my_investor_profile_state.freezed.dart';

@freezed
class MyInvestorProfileState with _$MyInvestorProfileState {
  const factory MyInvestorProfileState.initial() = _Initial;
  const factory MyInvestorProfileState.loading() = Loading;
  const factory MyInvestorProfileState.loaded({
    required InvestorProfileModel profile,
  }) = Loaded;
  const factory MyInvestorProfileState.error({required String message}) = Error;
}
