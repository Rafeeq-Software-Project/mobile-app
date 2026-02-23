import 'dart:async';
import 'package:rafeeq_app/core/network/api_client.dart';
import 'package:rafeeq_app/core/services/storage/auth_local_storage.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/refresh_token_request_model.dart';

class TokenManager {
  final AuthLocalStorage _storage;
  final ApiClient _apiClient;

  TokenManager(this._storage, this._apiClient);

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  Future<String?> getAccessToken() async {
    return await _storage.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _storage.getRefreshToken();
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiry,
  }) async {
    await _storage.updateTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiry: expiry,
    );
  }

  /// refresh token with lock to prevent multiple calls
  Future<bool> refreshToken() async {
    if (_isRefreshing) {
      return _refreshCompleter!.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer();

    try {
      final refresh = await getRefreshToken();
      if (refresh == null || refresh.isEmpty) {
        _refreshCompleter!.complete(false);
        return false;
      }

      final response = await _apiClient.refreshToken(
        RefreshTokenRequest(refreshToken: refresh),
      );

      await saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        expiry: response.expiresAt,
      );

      _refreshCompleter!.complete(true);
      return true;
    } catch (e) {
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      _isRefreshing = false;
    }
  }
}
