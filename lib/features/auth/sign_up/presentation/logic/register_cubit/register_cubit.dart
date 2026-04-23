import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/helpers/shared_pref_helper.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/services/storage/auth_local_storage.dart';
import 'package:rafeeq_app/core/utils/shared_pref_keys.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_request_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/repos/register_repo.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;
  final AuthLocalStorage authLocalStorage;

  RegisterCubit(this.registerRepo, this.authLocalStorage)
    : super(RegisterState.initial());

  Future<void> register(RegisterRequestModel request) async {
    emit(RegisterState.loading());
    final result = await registerRepo.register(request);
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
        SharedPrefHelper.setData(key: SharedPrefKeys.isLoggedIn, value: true);
        emit(RegisterState.success(response));
      },
      failure: (error) => emit(RegisterState.failure(error.toString())),
    );
  }
}
