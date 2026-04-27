import '../../../shared/services/api_client.dart';

class AuthApi {
  /// =========================
  /// 🔐 LOGIN
  /// =========================
  static Future<Map<String, dynamic>> login(
      Map<String, dynamic> data) async {
    return await ApiClient.post("/auth/login", data);
  }

  /// =========================
  /// 📝 REGISTER CLIENT
  /// =========================
  static Future<Map<String, dynamic>> registerClient(
      Map<String, dynamic> data) async {
    return await ApiClient.post("/auth/register-client", data);
  }

  /// =========================
  /// 🏪 REGISTER COMMERCANT
  /// =========================
  static Future<Map<String, dynamic>> registerCommercant(
      Map<String, dynamic> data) async {
    return await ApiClient.post("/auth/register-commercant", data);
  }

  /// =========================
  /// 🚚 REGISTER LIVREUR
  /// =========================
  static Future<Map<String, dynamic>> registerLivreur(
      Map<String, dynamic> data) async {
    return await ApiClient.post("/auth/register-livreur", data);
  }

  /// =========================
  /// 📧 FORGOT PASSWORD (OTP)
  /// =========================
  static Future<Map<String, dynamic>> forgot(
      Map<String, dynamic> data) async {
    return await ApiClient.post("/auth/forgot-password", data);
  }

  /// =========================
  /// 🔄 RESET PASSWORD
  /// =========================
  static Future<Map<String, dynamic>> reset(
      Map<String, dynamic> data) async {
    return await ApiClient.post("/auth/reset-password", data);
  }

  /// =========================
  /// 👤 GET CURRENT USER
  /// =========================
  static Future<Map<String, dynamic>> getMe(String token) async {
    return await ApiClient.get("/auth/me", token);
  }

  /// =========================
  /// 🚪 LOGOUT (اختياري)
  /// =========================
  static Future<Map<String, dynamic>> logout(String token) async {
    return await ApiClient.postWithToken("/auth/logout", {}, token);
  }
}