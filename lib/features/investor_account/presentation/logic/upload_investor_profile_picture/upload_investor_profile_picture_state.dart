import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_picture/upload/upload_investor_profile_picture_response.dart';

part 'upload_investor_profile_picture_state.freezed.dart';

@freezed
class UploadInvestorProfilePictureState
    with _$UploadInvestorProfilePictureState {
  const factory UploadInvestorProfilePictureState.initial() = _Initial;

  const factory UploadInvestorProfilePictureState.loading() = _Loading;

  const factory UploadInvestorProfilePictureState.success(
    UploadInvestorProfilePictureResponse response,
  ) = _Success;

  const factory UploadInvestorProfilePictureState.error(String message) =
      _Error;
}
