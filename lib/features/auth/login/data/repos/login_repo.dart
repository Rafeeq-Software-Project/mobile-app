import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_request_model.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_response_model.dart';

class LoginRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;
  LoginRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) async {
    return await apiHandler.makeRequest(() => apiClient.login(request));
  }
}
