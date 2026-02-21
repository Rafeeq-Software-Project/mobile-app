import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/reset_password/reset_password_response_model.dart';
part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.loading() = Loading;
  const factory ResetPasswordState.success(
    ResetPasswordResponseModel response,
  ) = Success;
  const factory ResetPasswordState.failure(String error) = Failure;
}
