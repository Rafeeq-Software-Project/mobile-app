import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/create_project/data/models/create_project_request.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';

class CreateProjectRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  CreateProjectRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<ProjectModel>> createProject(
    CreateProjectRequest request,
  ) async {
    try {
      final response = await apiHandler.makeRequest(
        () => apiClient.createProject(request),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
