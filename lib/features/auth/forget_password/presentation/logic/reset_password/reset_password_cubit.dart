import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/reset_password/reset_password_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/reset_password_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/reset_password/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.resetPasswordRepo)
    : super(ResetPasswordState.initial());
  final ResetPasswordRepo resetPasswordRepo;
  Future<void> resetPassword(ResetPasswordRequestModel response) async {
    emit(ResetPasswordState.loading());
    final result = await resetPasswordRepo.resetPassword(response);
    result.when(
      success: (response) => emit(ResetPasswordState.success(response)),
      failure: (error) => emit(ResetPasswordState.failure(error.toString())),
    );
  }
}
