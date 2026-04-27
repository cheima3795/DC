import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../features/auth/controllers/auth_controller.dart';
import '../../../../shared/components/custom_button.dart';
import '../../../../routes/app_routes.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  bool loading = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    /// 🔄 auto refresh كل 5 ثواني
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      checkStatus();
    });
  }

  /// 🔍 CHECK STATUS
  Future<void> checkStatus() async {
    setState(() {
      loading = true;
    });

    final data = await AuthController.getMe();

    setState(() {
      loading = false;
    });

    /// ❌ error / token invalid
    if (data["user"] == null) {
      await AuthController.logout();
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    final status = data["user"]["status"];

    /// ✅ approved
    if (status == "approuve") {
      timer?.cancel();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      return;
    }

    /// ❌ refused
    if (status == "refuse") {
      timer?.cancel();
      await AuthController.logout();
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    /// ⏳ en_attente → stay
  }

  /// 🚪 LOGOUT
  Future<void> handleLogout() async {
    timer?.cancel();
    await AuthController.logout();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 🔵 LOGO
              Image.asset("assets/images/logo.png", height: 120),

              const SizedBox(height: 30),

              /// 🔄 LOADER
              if (loading)
                const CircularProgressIndicator(color: Colors.blue),

              const SizedBox(height: 30),

              const Text(
                "En attente",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Votre compte est en attente de validation par l'administrateur.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              /// 🔄 MANUAL CHECK
              CustomButton(
                text: "Vérifier le statut",
                loading: loading,
                onPressed: checkStatus,
              ),

              const SizedBox(height: 15),

              /// 🚪 LOGOUT
              CustomButton(
                text: "Logout",
                onPressed: handleLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}