import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/components/custom_input.dart';
import '../../../shared/components/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedRole = 'client';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          _background(),

          /// CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Expanded(child: _glassCard()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomInput(hint: "Nom", icon: Icons.person),
                const SizedBox(height: 15),

                const CustomInput(hint: "Email", icon: Icons.email),
                const SizedBox(height: 15),

                const CustomInput(hint: "Telephone", icon: Icons.phone),
                const SizedBox(height: 15),

                const CustomInput(
                  hint: "Mot de passe",
                  isPassword: true,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 20),

                /// ROLE SELECTOR 🔥
                Row(
                  children: [
                    _role("client"),
                    _role("commercant"),
                    _role("livreur"),
                  ],
                ),

                const SizedBox(height: 20),

                if (selectedRole == "livreur")
                  const CustomInput(
                    hint: "Matricule véhicule",
                    icon: Icons.directions_car,
                  ),

                const SizedBox(height: 30),

                CustomButton(text: "Register", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _role(String role) {
    final selected = selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(role, style: const TextStyle(color: Colors.white)),
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
