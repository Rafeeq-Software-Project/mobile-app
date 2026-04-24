import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';

class DeleteProjectRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  DeleteProjectRepo(this.apiClient, this.apiHandler);

  Future<ApiResult<String>> deleteProject(int projectId) async {
    final result = await apiHandler.makeRequest(
      () => apiClient.deleteProject(projectId),
    );
    return result.when(
      success: (response) => ApiResult.success(response.message),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
