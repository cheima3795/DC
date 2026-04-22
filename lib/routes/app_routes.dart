import 'package:flutter/material.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/register_page.dart';
import '../features/auth/pages/forgot_password_page.dart';
import '../features/auth/pages/reset_password_page.dart';
import '../features/user/common/pages/home_page.dart';
import '../features/user/common/pages/waiting_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const forgot = '/forgot';
  static const reset = '/reset';
  static const home = '/home';
  static const waiting = '/waiting';

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgot: (_) => const ForgotPasswordPage(),
    reset: (_) => const ResetPasswordPage(),
    home: (_) => const HomePage(),
    waiting: (_) => const WaitingPage(),
  };
}
