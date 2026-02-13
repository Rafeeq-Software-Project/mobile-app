import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_request_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/repos/register_repo.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;
  RegisterCubit(this.registerRepo) : super(RegisterState.initial());

  Future<void> register(RegisterRequestModel request) async {
    emit(RegisterState.loading());
    final result = await registerRepo.register(request);
    result.when(
      success: (response) => emit(RegisterState.success(response)),
      failure: (error) => emit(RegisterState.failure(error.toString())),
    );
  }
}
