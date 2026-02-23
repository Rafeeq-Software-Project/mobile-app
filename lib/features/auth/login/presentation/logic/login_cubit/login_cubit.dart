import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/services/storage/auth_local_storage.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_request_model.dart';
import 'package:rafeeq_app/features/auth/login/data/repos/login_repo.dart';
import 'package:rafeeq_app/features/auth/login/presentation/logic/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  final AuthLocalStorage authLocalStorage;
  LoginCubit(this.loginRepo, this.authLocalStorage)
    : super(LoginState.initial());
  Future<void> login(LoginRequestModel request) async {
    emit(LoginState.loading());
    final result = await loginRepo.login(request);
    result.when(
      success: (response) async {
        await authLocalStorage.saveCurrentUserData(
          token: response.accessToken,
          refreshToken: response.refreshToken,
          userIdValue: response.userId.toString(),
          firstNameValue: response.firstName,
          lastNameValue: response.lastName,
          emailValue: response.email,
          roleIdValue: response.roleId,
          tokenExpiry: response.expiresAt,
          usernameValue: response.username,
          profileImage: response.profilePictureUrl,
          roleNameValue: response.roleName,
          isRegisterCompletedValue: true,
        );
        emit(LoginState.success(response));
      },
      failure: (error) => emit(LoginState.failure(error.toString())),
    );
  }
}
