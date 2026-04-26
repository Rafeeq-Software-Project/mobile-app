import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/pending_draft_model.dart';

class GetAllPendingDraftsRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  GetAllPendingDraftsRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<List<PendingDraftModel>>> getAllPendingDrafts() async {
    final response = await apiHandler.makeRequest(
      () => apiClient.getAllPendingDrafts(),
    );
    return response;
  }
}
