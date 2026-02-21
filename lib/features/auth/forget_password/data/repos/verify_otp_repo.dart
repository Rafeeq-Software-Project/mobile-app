import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/verify_otp/verify_otp_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/verify_otp/verify_otp_response_model.dart';

class VerifyOtpRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;
  VerifyOtpRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<VerifyOtpResponseModel>> verifyOtp(String otp) async {
    return await apiHandler.makeRequest(
      () => apiClient.verifyOtp(VerifyOtpRequestModel(otp: otp)),
    );
  }
}
