import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_request_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_response_model.dart';

class RegisterRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;
  RegisterRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<RegisterResponseModel>> register(
    RegisterRequestModel request,
  ) async {
    return await apiHandler.makeRequest(() => apiClient.register(request));
  }
}
