import 'package:flutter/material.dart';
import '../../../shared/components/custom_input.dart';
import '../../../shared/components/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  bool loading = false;
  String error = "";

  void handleLogin() async {
    setState(() => error = "");

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        error = "Tous les champs sont obligatoires";
      });
      return;
    }

    setState(() => loading = true);

    final data = await AuthController.login(email, password);

    if (!mounted) return;

    setState(() => loading = false);

    if (data["token"] == null) {
      setState(() {
        error = data["message"] ?? "Erreur serveur";
      });
      return;
    }

    final status = data["user"]["status"];

    if (status == "en_attente") {
      Navigator.pushReplacementNamed(context, AppRoutes.waiting);
    } else if (status == "approuve") {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      setState(() {
        error = "Compte refusé";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 60),

                /// 🔵 LOGO (أكبر + أنظف)
                Center(
                  child: Image.asset(
                    "assets/images/logo.jpeg",
                    height: 180, // 🔥 كبرناه
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 40),

                /// 🔥 CARD
                Container(
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
                        "Login",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// ❌ ERROR
                      if (error.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      /// EMAIL
                      CustomInput(
                        hint: "Email",
                        icon: Icons.email,
                        onChanged: (val) => email = val,
                      ),

                      const SizedBox(height: 20),

                      /// PASSWORD
                      CustomInput(
                        hint: "Mot de passe",
                        isPassword: true,
                        icon: Icons.lock,
                        onChanged: (val) => password = val,
                      ),

                      const SizedBox(height: 15),

                      /// FORGOT
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.forgot);
                          },
                          child: const Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// BUTTON
                      CustomButton(
                        text: "Login",
                        loading: loading,
                        onPressed: handleLogin,
                      ),

                      const SizedBox(height: 25),

                      /// REGISTER
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: const Text(
                            "Créer un compte",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}