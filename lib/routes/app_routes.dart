import 'package:flutter/material.dart';

/// AUTH PAGES
import '../features/auth/pages/splash_page.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/register_page.dart';
import '../features/auth/pages/forgot_password_page.dart';
import '../features/auth/pages/reset_password_page.dart';

/// USER PAGES
import '../features/user/common/pages/home_page.dart';
import '../features/user/common/pages/waiting_page.dart';

class AppRoutes {
  /// 🔥 ROUTE NAMES
  static const splash = '/splash';
  static const login = '/';
  static const register = '/register';
  static const forgot = '/forgot';
  static const reset = '/reset';
  static const home = '/home';
  static const waiting = '/waiting';

  /// 🔥 ROUTES MAP
  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgot: (_) => const ForgotPasswordPage(),
    reset: (_) => const ResetPasswordPage(),
    home: (_) => const HomePage(),
    waiting: (_) => const WaitingPage(),
  };

  /// 🔥 UNKNOWN ROUTE (fallback)
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const LoginPage(),
    );
  }
}