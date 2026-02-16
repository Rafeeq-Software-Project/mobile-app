import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_otp_state.freezed.dart';

@freezed
class SendOtpState with _$SendOtpState {
  const factory SendOtpState.initial() = _Initial;
  const factory SendOtpState.loading() = Loading;
  const factory SendOtpState.success(String email) = Success;
  const factory SendOtpState.failure(String error) = Failure;
}
