import 'package:flutter/material.dart';
import '../../../shared/components/custom_input.dart';
import '../../../shared/components/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String email = "";
  String otp = "";
  String password = "";

  bool loading = false;
  String error = "";
  String success = "";

  /// 🔄 RESET FUNCTION
  void handleReset() async {
    setState(() {
      error = "";
      success = "";
    });

    /// ✅ VALIDATION
    if (email.isEmpty || otp.isEmpty || password.isEmpty) {
      setState(() {
        error = "Tous les champs sont obligatoires";
      });
      return;
    }

    setState(() {
      loading = true;
    });

    final data =
    await AuthController.reset(email, otp, password);

    setState(() {
      loading = false;
    });

    /// ❌ ERROR
    if (data["status"] != null) {
      setState(() {
        error = data["message"];
      });
      return;
    }

    /// ✅ SUCCESS
    setState(() {
      success = data["message"] ?? "Mot de passe changé";
    });

    /// 🔄 REDIRECT
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// 🔵 LOGO
              Image.asset("assets/images/logo.jpeg", height: 120),

              const SizedBox(height: 30),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Enter OTP and new password",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 30),

                      /// ERROR
                      if (error.isNotEmpty)
                        Text(error, style: const TextStyle(color: Colors.red)),

                      /// SUCCESS
                      if (success.isNotEmpty)
                        Text(success,
                            style: const TextStyle(color: Colors.green)),

                      const SizedBox(height: 10),

                      CustomInput(
                        hint: "Email",
                        icon: Icons.email,
                        onChanged: (v) => email = v,
                      ),

                      const SizedBox(height: 15),

                      CustomInput(
                        hint: "OTP",
                        icon: Icons.lock,
                        onChanged: (v) => otp = v,
                      ),

                      const SizedBox(height: 15),

                      CustomInput(
                        hint: "New Password",
                        isPassword: true,
                        icon: Icons.lock,
                        onChanged: (v) => password = v,
                      ),

                      const SizedBox(height: 30),

                      CustomButton(
                        text: "Reset Password",
                        loading: loading,
                        onPressed: handleReset,
                      ),

                      const Spacer(),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Retour au login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}