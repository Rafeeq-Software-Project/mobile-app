import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/repos/verify_otp_repo.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/verify_otp/verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit(this.verifyOtpRepo) : super(VerifyOtpState.initial());
  final VerifyOtpRepo verifyOtpRepo;
  Future<void> verifyOtp(String otp) async {
    emit(VerifyOtpState.loading());
    final result = await verifyOtpRepo.verifyOtp(otp);
    result.when(
      success: (response) => emit(VerifyOtpState.success(response)),
      failure: (error) => emit(VerifyOtpState.failure(error.toString())),
    );
  }
}
