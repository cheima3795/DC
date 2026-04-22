import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/components/custom_input.dart';
import '../../../shared/components/custom_button.dart';
import '../../../routes/app_routes.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Expanded(child: _glass(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glass(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              const CustomInput(hint: "Email", icon: Icons.email),
              const SizedBox(height: 15),

              const CustomInput(hint: "OTP", icon: Icons.lock),
              const SizedBox(height: 15),

              const CustomInput(
                hint: "New Password",
                isPassword: true,
                icon: Icons.lock,
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: "Reset Password",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF00C896)],
        ),
      ),
    );
  }
}
