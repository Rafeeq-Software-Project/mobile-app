import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_response_model.dart';
part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = Loading;
  const factory LoginState.success(LoginResponseModel response) = Success;
  const factory LoginState.failure(String error) = Failure;
}
