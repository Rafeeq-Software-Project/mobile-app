import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/otp/otp_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/otp/otp_response_model.dart';

class SendOtpRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;
  SendOtpRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<OtpResponseModel>> sendOtp(String email) async {
    return await apiHandler.makeRequest(
      () => apiClient.forgotPassword(OtpRequestModel(email: email)),
    );
  }
}
