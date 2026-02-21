import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/resend_otp_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/resend_otp/resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit(this.resendOtpRepo) : super(ResendOtpState.initial());
  final ResendOtpRepo resendOtpRepo;
  Future<void> resendOtp(String email) async {
    emit(ResendOtpState.loading());
    final result = await resendOtpRepo.sendOtp(email);
    result.when(
      success: (response) => emit(ResendOtpState.success(email)),
      failure: (error) => emit(ResendOtpState.failure(error.toString())),
    );
  }
}
