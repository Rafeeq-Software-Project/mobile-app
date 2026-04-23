import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';

class ProjectDetailsRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  ProjectDetailsRepo(this.apiClient, this.apiHandler);

  Future<ApiResult<ProjectModel>> getProjectDetails(int id) async {
    return await apiHandler.makeRequest(() => apiClient.getProjectDetails(id));
  }
}
