import 'package:rafeeq_app/core/di/service_locator.dart';
import 'package:rafeeq_app/core/utils/secure_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/secure_storage_helper.dart';
import '../utils/shared_pref_keys.dart';

part 'user_local_data_model.dart';

class CurrentUser {
  CurrentUser._();

  static late _UserLocalData _data;
  static bool _isInitialized = false;

  static _UserLocalData get data {
    if (!_isInitialized) {
      throw Exception('CurrentUser not initialized. Call init() first.');
    }
    return _data;
  }

  static Future<void> init() async {
    await _initUserData();
    _isInitialized = true;
  }

  static bool isLoggedIn() {
    return _data.accessToken.isNotEmpty &&
        _data.expiresAt.isAfter(DateTime.now());
  }

  static Future<void> _initUserData() async {
    final prefs = getIt<SharedPreferences>();
    final secure = getIt<SecureStorageHelper>();

    final accessToken =
        await secure.readData(SecureStorageKeys.accessToken) ?? '';

    final refreshToken =
        await secure.readData(SecureStorageKeys.refreshToken) ?? '';

    final expiryString = prefs.getString(SharedPrefKeys.expiresAt);

    _data = _UserLocalData(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userId: prefs.getString(SharedPrefKeys.userId.toString()) ?? '0',
      email: prefs.getString(SharedPrefKeys.email) ?? '',
      firstName: prefs.getString(SharedPrefKeys.firstName) ?? '',
      lastName: prefs.getString(SharedPrefKeys.lastName) ?? '',
      username: prefs.getString(SharedPrefKeys.username) ?? '',
      profilePictureUrl: prefs.getString(SharedPrefKeys.profilePictureUrl),
      roleName: prefs.getString(SharedPrefKeys.roleName) ?? '',
      roleId: prefs.getInt(SharedPrefKeys.roleId.toString()) ?? 0,
      expiresAt: expiryString != null
          ? DateTime.tryParse(expiryString) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  static Future<void> reload() async {
    await _initUserData();
  }
}
