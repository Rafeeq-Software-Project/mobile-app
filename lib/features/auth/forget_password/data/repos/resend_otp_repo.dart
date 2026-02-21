import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/otp/otp_request_model.dart'
    show OtpRequestModel;
import 'package:rafeeq_app/features/auth/forget_password/data/models/otp/otp_response_model.dart';

class ResendOtpRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;
  ResendOtpRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<OtpResponseModel>> sendOtp(String email) async {
    return await apiHandler.makeRequest(
      () => apiClient.resendOtp(OtpRequestModel(email: email)),
    );
  }
}
