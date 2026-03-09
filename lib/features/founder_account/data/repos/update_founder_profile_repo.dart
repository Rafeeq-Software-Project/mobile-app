import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_account/data/models/update_founder_profile/update_founder_profile_request.dart';
import 'package:rafeeq_app/features/founder_account/data/models/update_founder_profile/update_founder_profile_response.dart';

class UpdateFounderProfileRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  UpdateFounderProfileRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<UpdateFounderProfileResponse>> updateFounderProfile(
    UpdateFounderProfileRequest request,
  ) async {
    return await apiHandler.makeRequest<UpdateFounderProfileResponse>(() async {
      return await apiClient.updateFounderProfile(request);
    });
  }
}
