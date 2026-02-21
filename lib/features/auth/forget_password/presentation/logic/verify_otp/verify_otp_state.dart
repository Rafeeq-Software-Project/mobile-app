import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/verify_otp/verify_otp_response_model.dart';
part 'verify_otp_state.freezed.dart';

@freezed
class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState.initial() = _Initial;
  const factory VerifyOtpState.loading() = Loading;
  const factory VerifyOtpState.success(VerifyOtpResponseModel response) =
      Success;
  const factory VerifyOtpState.failure(String error) = Failure;
}
