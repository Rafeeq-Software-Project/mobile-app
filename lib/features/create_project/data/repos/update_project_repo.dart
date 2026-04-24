import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/create_project/data/models/create_project_request.dart';
import 'package:rafeeq_app/features/create_project/data/models/update_project_response.dart';

class UpdateProjectRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  UpdateProjectRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<UpdateProjectResponse>> updateProject(
    int projectId,
    CreateProjectRequest request,
  ) async {
    try {
      final response = await apiHandler.makeRequest(
        () => apiClient.updateProject(projectId, request),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
