import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/components/custom_input.dart';
import '../../../shared/components/custom_button.dart';
import '../../../routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF00C896)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// 🔵 FLOATING CIRCLE (depth effect)
          Positioned(
            top: -80,
            right: -50,
            child: _circle(200, Colors.white.withOpacity(0.1)),
          ),

          Positioned(
            bottom: -100,
            left: -60,
            child: _circle(250, Colors.white.withOpacity(0.08)),
          ),

          /// CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    "Ghaytak",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Smart local shopping",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 40),

                  /// GLASS CARD 🔥
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),

                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),

                              const CustomInput(hint: "Email"),
                              const SizedBox(height: 20),

                              const CustomInput(
                                hint: "Mot de passe",
                                isPassword: true,
                              ),

                              const SizedBox(height: 15),

                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.forgot,
                                  ),
                                  child: const Text(
                                    "Mot de passe oublié ?",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),

                              CustomButton(
                                text: "Login",
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.waiting,
                                  );
                                },
                              ),

                              const Spacer(),

                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.register,
                                ),
                                child: const Text(
                                  "Créer un compte",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
