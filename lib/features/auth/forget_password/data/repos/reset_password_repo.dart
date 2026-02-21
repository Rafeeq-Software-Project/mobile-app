import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/reset_password/reset_password_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/reset_password/reset_password_response_model.dart';

class ResetPasswordRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;
  ResetPasswordRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<ResetPasswordResponseModel>> resetPassword(
    ResetPasswordRequestModel response,
  ) async {
    return await apiHandler.makeRequest(
      () => apiClient.resetPassword(response),
    );
  }
}
