import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/founder_account/data/models/founder_profile.dart';

class GetMyFounderProfileRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  GetMyFounderProfileRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<FounderProfile>> getFounderProfile() async {
    return await apiHandler.makeRequest<FounderProfile>(() async {
      return await apiClient.getMyFounderProfile();
    });
  }
}
