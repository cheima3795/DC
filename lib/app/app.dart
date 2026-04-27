import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../styles/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// 🔕 إزالة debug banner
      debugShowCheckedModeBanner: false,

      /// 🎨 THEME
      theme: AppTheme.light,

      /// 🚀 START APP (Splash)
      initialRoute: AppRoutes.splash,

      /// 📌 ROUTES
      routes: AppRoutes.routes,

      /// ❌ UNKNOWN ROUTE (fallback)
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}