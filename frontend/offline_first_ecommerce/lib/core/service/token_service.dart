import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart'; // debugPrint ke liye

class TokenService {
  final _storage = const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      synchronizable: false,
    ),
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _storage.write(key: 'accessToken', value: accessToken);
      await _storage.write(key: 'refreshToken', value: refreshToken);
      debugPrint("✅ Tokens saved successfully");
    } catch (e) {
      debugPrint("Error saving tokens: $e");
      rethrow;
    }
  }

  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: 'accessToken');
    } catch (e) {
      debugPrint("Error reading access token: $e");
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: 'refreshToken');
    } catch (e) {
      debugPrint("Error reading refresh token: $e");
      return null;
    }
  }

  Future<void> clearTokens() async {
    try {
      await _storage.deleteAll();
      debugPrint("✅ Tokens cleared");
    } catch (e) {
      debugPrint("Error clearing tokens: $e");
      rethrow;
    }
  }
}
