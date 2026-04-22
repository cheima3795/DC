import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final IconData? icon;

  const CustomInput({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.icon,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool obscure = true;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      cursorColor: Colors.white,

      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white70),

        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: Colors.white70)
            : null,

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              )
            : null,

        filled: true,
        fillColor: Colors.white.withOpacity(0.08),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
