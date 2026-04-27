import '../services/auth_api.dart';
import '../../../shared/utils/auth.dart';

class AuthController {
  /// =========================
  /// 🔐 LOGIN
  /// =========================
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final data = await AuthApi.login({
      "email": email,
      "mot_de_passe": password,
    });

    /// ✅ success
    if (data["token"] != null) {
      await saveToken(data["token"]);
    }

    return data;
  }

  /// =========================
  /// 📝 REGISTER
  /// =========================
  static Future<Map<String, dynamic>> register(
      String role,
      Map<String, dynamic> form,
      ) async {
    Map<String, dynamic> data;

    if (role == "client") {
      data = await AuthApi.registerClient(form);
    } else if (role == "commercant") {
      data = await AuthApi.registerCommercant(form);
    } else {
      data = await AuthApi.registerLivreur(form);
    }

    return data;
  }

  /// =========================
  /// 📧 FORGOT PASSWORD
  /// =========================
  static Future<Map<String, dynamic>> forgot(String email) async {
    return await AuthApi.forgot({
      "email": email,
    });
  }

  /// =========================
  /// 🔄 RESET PASSWORD
  /// =========================
  static Future<Map<String, dynamic>> reset(
      String email,
      String otp,
      String password,
      ) async {
    return await AuthApi.reset({
      "email": email,
      "otp": otp,
      "password": password,
    });
  }

  /// =========================
  /// 👤 GET CURRENT USER
  /// =========================
  static Future<Map<String, dynamic>> getMe() async {
    final token = await getToken();

    if (token == null) {
      return {"message": "Not authenticated"};
    }

    return await AuthApi.getMe(token);
  }

  /// =========================
  /// 🚪 LOGOUT
  /// =========================
  static Future<void> logout() async {
    final token = await getToken();

    if (token != null) {
      await AuthApi.logout(token);
    }

    await removeToken();
  }
}