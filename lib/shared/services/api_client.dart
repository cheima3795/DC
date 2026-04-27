import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  /// 🔥 IMPORTANT: بدل IP حسب جهازك
  /// مثالك:
  static const String baseUrl = "http://172.20.10.5:8000/api";

  /// =========================
  /// 🔵 POST (بدون token)
  /// =========================
  static Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> data,
      ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        "message": "Erreur réseau",
      };
    }
  }

  /// =========================
  /// 🔵 POST (مع token)
  /// =========================
  static Future<Map<String, dynamic>> postWithToken(
      String endpoint,
      Map<String, dynamic> data,
      String token,
      ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        "message": "Erreur réseau",
      };
    }
  }

  /// =========================
  /// 🔵 GET (مع token)
  /// =========================
  static Future<Map<String, dynamic>> get(
      String endpoint,
      String token,
      ) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl$endpoint"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        "message": "Erreur réseau",
      };
    }
  }

  /// =========================
  /// 🔵 GET (بدون token)
  /// =========================
  static Future<Map<String, dynamic>> getPublic(
      String endpoint,
      ) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl$endpoint"),
        headers: {
          "Accept": "application/json",
        },
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        "message": "Erreur réseau",
      };
    }
  }

  /// =========================
  /// 🔥 RESPONSE HANDLER
  /// =========================
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);

    /// ✅ SUCCESS
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    /// ❌ ERROR (Laravel format)
    return {
      "message": data["message"] ?? "Erreur serveur",
      "status": response.statusCode,
    };
  }
}