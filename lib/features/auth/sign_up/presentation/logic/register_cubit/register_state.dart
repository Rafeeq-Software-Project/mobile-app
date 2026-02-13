import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_response_model.dart';
part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = Loading;
  const factory RegisterState.success(RegisterResponseModel response) = Success;
  const factory RegisterState.failure(String error) = Failure;
}
