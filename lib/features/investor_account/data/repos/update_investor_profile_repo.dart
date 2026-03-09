import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/investor_account/data/models/update_investor_profile/update_investor_profile_request.dart';
import 'package:rafeeq_app/features/investor_account/data/models/update_investor_profile/update_investor_profile_response.dart';

class UpdateInvestorProfileRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  UpdateInvestorProfileRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<UpdateInvestorProfileResponse>> updateInvestorProfile(
    UpdateInvestorProfileRequest request,
  ) async {
    return await apiHandler.makeRequest<UpdateInvestorProfileResponse>(
      () async {
        return await apiClient.updateInvestorProfile(request);
      },
    );
  }
}
