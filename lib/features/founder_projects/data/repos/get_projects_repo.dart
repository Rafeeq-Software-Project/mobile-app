import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';

class GetProjectsRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  GetProjectsRepo(this.apiClient, this.apiHandler);

  Future<ApiResult<List<ProjectModel>>> getProjects() async {
    return await apiHandler.makeRequest(() => apiClient.getAllProjects());
  }
}
