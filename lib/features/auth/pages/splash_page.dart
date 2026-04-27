import 'package:flutter/material.dart';
import '../../../shared/utils/auth.dart';
import '../controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    startApp();
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await getToken();

    /// ❌ لا يوجد token
    if (token == null) {
      go(AppRoutes.login);
      return;
    }

    final data = await AuthController.getMe();

    /// ❌ token غير صالح
    if (data["user"] == null) {
      await AuthController.logout();
      go(AppRoutes.login);
      return;
    }

    final status = data["user"]["status"];

    /// ⏳ en attente
    if (status == "en_attente") {
      go(AppRoutes.waiting);
      return;
    }

    /// ❌ refusé
    if (status == "refuse") {
      await AuthController.logout();
      go(AppRoutes.login);
      return;
    }

    /// ✅ approuvé
    go(AppRoutes.home);
  }

  /// 🔥 navigation safe
  void go(String route) {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", height: 120),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}