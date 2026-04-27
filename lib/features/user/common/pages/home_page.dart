import 'package:flutter/material.dart';
import '../../../../features/auth/controllers/auth_controller.dart';
import '../../../../shared/components/loader.dart';
import '../../../../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  /// 🔥 INIT
  void init() async {
    final data = await AuthController.getMe();

    /// ❌ not authenticated
    if (data["user"] == null) {
      await AuthController.logout();
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    final user = data["user"];
    final status = user["status"];
    final role = user["role"];

    /// ⏳ en_attente
    if (status == "en_attente") {
      Navigator.pushReplacementNamed(context, AppRoutes.waiting);
      return;
    }

    /// ❌ refuse
    if (status == "refuse") {
      await AuthController.logout();
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    /// ✅ approuve → role routing
    routeByRole(role);
  }

  /// 🔥 ROLE ROUTING
  void routeByRole(String role) {
    if (role == "client") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Client Home")),
          ),
        ),
      );
      return;
    }

    if (role == "commercant") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Commercant Dashboard")),
          ),
        ),
      );
      return;
    }

    if (role == "livreur") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Livreur Dashboard")),
          ),
        ),
      );
      return;
    }

    /// fallback
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loader(),
    );
  }
}