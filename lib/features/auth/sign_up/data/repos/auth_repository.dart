import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/services/storage/auth_local_storage.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/refresh_token_request_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final AuthLocalStorage _authLocal;

  AuthRepository(this._apiClient, this._authLocal);

  Future<bool> refreshToken() async {
    final refresh = await _authLocal.getRefreshToken();
    if (refresh == null || refresh.isEmpty) return false;

    try {
      final response = await _apiClient.refreshToken(
        RefreshTokenRequest(refreshToken: refresh),
      );

      await _authLocal.updateTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        expiry: response.expiresAt,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
