import 'package:rafeeq_app/core/di/service_locator.dart';
import 'package:rafeeq_app/core/helpers/secure_storage_helper.dart';
import 'package:rafeeq_app/core/local_data/current_user.dart';
import 'package:rafeeq_app/core/utils/secure_storage_keys.dart';
import 'package:rafeeq_app/core/utils/shared_pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  final SecureStorageHelper _secureStorage = getIt<SecureStorageHelper>();
  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  final String _tokenKey = SecureStorageKeys.accessToken;
  final String _refreshTokenKey = SecureStorageKeys.refreshToken;
  static const String userId = SharedPrefKeys.userId;
  static const String email = SharedPrefKeys.email;
  static const String firstName = SharedPrefKeys.firstName;
  static const String lastName = SharedPrefKeys.lastName;
  static const String username = SharedPrefKeys.username;
  static const String profilePictureUrl = SharedPrefKeys.profilePictureUrl;
  static const String roleName = SharedPrefKeys.roleName;
  static const int roleId = SharedPrefKeys.roleId;
  static const String expiresAt = SharedPrefKeys.expiresAt;
  static const String isRegisterCompleted = SharedPrefKeys.isRegisterCompleted;

  Future<void> saveCurrentUserData({
    required String token,
    required String userIdValue,
    required String firstNameValue,
    required String lastNameValue,
    required String emailValue,
    required int roleIdValue,
    required DateTime tokenExpiry,
    required String usernameValue,
    String? profileImage,
    required String refreshToken,
    required String roleNameValue,
    required bool isRegisterCompletedValue,
  }) async {
    await _secureStorage.writeData(_tokenKey, token);
    await _secureStorage.writeData(_refreshTokenKey, refreshToken);
    await _sharedPreferences.setString(userId, userIdValue);
    await _sharedPreferences.setString(firstName, firstNameValue);
    await _sharedPreferences.setString(lastName, lastNameValue);
    await _sharedPreferences.setString(email, emailValue);
    await _sharedPreferences.setInt(roleId.toString(), roleIdValue);
    await _sharedPreferences.setString(roleName, roleNameValue);
    await _sharedPreferences.setString(username, usernameValue);
    await _sharedPreferences.setString(profilePictureUrl, profileImage ?? '');
    await _sharedPreferences.setString(
      expiresAt,
      tokenExpiry.toIso8601String(),
    );
    await _sharedPreferences.setBool(
      isRegisterCompleted,
      isRegisterCompletedValue,
    );

    await CurrentUser.init();
  }

  Future<void> clearCurrentUserData() async {
    await _secureStorage.deleteData(_tokenKey);
    await _secureStorage.deleteData(_refreshTokenKey);
    await _sharedPreferences.remove(userId);
    await _sharedPreferences.remove(firstName);
    await _sharedPreferences.remove(lastName);
    await _sharedPreferences.remove(email);
    await _sharedPreferences.remove(roleId.toString());
    await _sharedPreferences.remove(roleName);
    await _sharedPreferences.remove(username);
    await _sharedPreferences.remove(profilePictureUrl);
    await _sharedPreferences.remove(expiresAt);
    await _sharedPreferences.remove(isRegisterCompleted);

    await CurrentUser.init();
  }

  Future<void> setRegisterCompleted() async {
    await _sharedPreferences.setBool(isRegisterCompleted, true);
    await CurrentUser.init();
  }

  Future<void> resetCurrentUserData() async {
    await clearCurrentUserData();
  }

  Future<void> updateTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiry,
  }) async {
    await _secureStorage.writeData(SecureStorageKeys.accessToken, accessToken);
    await _secureStorage.writeData(
      SecureStorageKeys.refreshToken,
      refreshToken,
    );
    await _sharedPreferences.setString(
      SharedPrefKeys.expiresAt,
      expiry.toIso8601String(),
    );
    await CurrentUser.reload();
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.getRefreshToken();
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.readData(_tokenKey);
  }
}
