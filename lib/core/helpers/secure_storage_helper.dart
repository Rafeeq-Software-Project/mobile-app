import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rafeeq_app/core/utils/secure_storage_keys.dart';

class SecureStorageHelper {
  final FlutterSecureStorage _secureStorage;

  SecureStorageHelper(this._secureStorage);

  // Keys
  static const String _tokenKey = SecureStorageKeys.accessToken;
  static const String _refreshTokenKey = SecureStorageKeys.refreshToken;

  // Write Data
  Future<void> writeData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Read Data
  Future<String?> readData(String key) async {
    return await _secureStorage.read(key: key);
  }

  // Delete Data
  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Clear All
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  // Access Token Helpers
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  // 🔹 Refresh Token Helpers
  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
