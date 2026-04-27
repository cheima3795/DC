import 'package:flutter/material.dart';
import '../../../shared/components/custom_input.dart';
import '../../../shared/components/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String role = "client";

  String nom = "";
  String email = "";
  String telephone = "";
  String password = "";
  String matricule = "";

  bool loading = false;
  String error = "";
  String success = "";

  /// 📝 REGISTER FUNCTION
  void handleRegister() async {
    setState(() {
      error = "";
      success = "";
    });

    /// ✅ VALIDATION
    if (nom.isEmpty ||
        email.isEmpty ||
        telephone.isEmpty ||
        password.isEmpty) {
      setState(() {
        error = "Tous les champs sont obligatoires";
      });
      return;
    }

    if (role == "livreur" && matricule.isEmpty) {
      setState(() {
        error = "Matricule obligatoire";
      });
      return;
    }

    setState(() {
      loading = true;
    });

    final data = await AuthController.register(role, {
      "nom": nom,
      "email": email,
      "telephone": telephone,
      "mot_de_passe": password,
      "matricule_vehicule": matricule,
    });

    setState(() {
      loading = false;
    });

    /// ❌ ERROR
    if (data["message"] != null && data["user"] == null) {
      setState(() {
        error = data["message"];
      });
      return;
    }

    /// ✅ SUCCESS
    setState(() {
      success = data["message"] ?? "Compte créé";
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
              const SizedBox(height: 20),

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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// ERROR
                        if (error.isNotEmpty)
                          Text(error, style: const TextStyle(color: Colors.red)),

                        /// SUCCESS
                        if (success.isNotEmpty)
                          Text(success,
                              style: const TextStyle(color: Colors.green)),

                        const SizedBox(height: 10),

                        CustomInput(
                          hint: "Nom",
                          icon: Icons.person,
                          onChanged: (v) => nom = v,
                        ),

                        const SizedBox(height: 15),

                        CustomInput(
                          hint: "Email",
                          icon: Icons.email,
                          onChanged: (v) => email = v,
                        ),

                        const SizedBox(height: 15),

                        CustomInput(
                          hint: "Telephone",
                          icon: Icons.phone,
                          onChanged: (v) => telephone = v,
                        ),

                        const SizedBox(height: 15),

                        CustomInput(
                          hint: "Mot de passe",
                          isPassword: true,
                          icon: Icons.lock,
                          onChanged: (v) => password = v,
                        ),

                        const SizedBox(height: 20),

                        /// 🔥 ROLE SELECTOR
                        Row(
                          children: [
                            _role("client"),
                            _role("commercant"),
                            _role("livreur"),
                          ],
                        ),

                        const SizedBox(height: 20),

                        if (role == "livreur")
                          CustomInput(
                            hint: "Matricule véhicule",
                            icon: Icons.directions_car,
                            onChanged: (v) => matricule = v,
                          ),

                        const SizedBox(height: 30),

                        CustomButton(
                          text: "Register",
                          loading: loading,
                          onPressed: handleRegister,
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Déjà un compte ? Login",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _role(String r) {
    final selected = role == r;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => role = r),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              r,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}