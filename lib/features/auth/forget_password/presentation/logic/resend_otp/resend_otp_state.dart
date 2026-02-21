import 'package:freezed_annotation/freezed_annotation.dart';
part 'resend_otp_state.freezed.dart';

@freezed
class ResendOtpState with _$ResendOtpState {
  const factory ResendOtpState.initial() = _Initial;
  const factory ResendOtpState.loading() = Loading;
  const factory ResendOtpState.success(String email) = Success;
  const factory ResendOtpState.failure(String error) = Failure;
}
