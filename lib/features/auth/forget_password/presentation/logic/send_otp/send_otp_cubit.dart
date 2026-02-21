import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/send_otp_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/send_otp/send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit(this.sendOtpRepo) : super(SendOtpState.initial());
  final SendOtpRepo sendOtpRepo;
  Future<void> sendOtp(String email) async {
    emit(SendOtpState.loading());
    final result = await sendOtpRepo.sendOtp(email);
    result.when(
      success: (response) => emit(SendOtpState.success(email)),
      failure: (error) => emit(SendOtpState.failure(error.toString())),
    );
  }
}
