import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/network/api_handler.dart';
import 'package:rafeeq_app/core/network/api_result.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';

class GetMyInvestorProfileRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  GetMyInvestorProfileRepo(this.apiClient, this.apiHandler);
  Future<ApiResult<InvestorProfileModel>> getInvestorProfile() async {
    return await apiHandler.makeRequest<InvestorProfileModel>(() async {
      return await apiClient.getMyInvestorProfile();
    });
  }
}
