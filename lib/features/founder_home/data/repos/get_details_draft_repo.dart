import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/pending_draft_model.dart';

class GetDetailsDraftRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  GetDetailsDraftRepo(this.apiClient, this.apiHandler);

  Future<ApiResult<PendingDraftModel>> getDetailsDraft(int projectId) async {
    final response = await apiHandler.makeRequest(
      () => apiClient.getDetailsDrafts(projectId),
    );

    return response;
  }
}
