import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final IconData? icon;
  final Function(String)? onChanged;

  const CustomInput({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.icon,
    this.onChanged,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword ? obscure : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hint,

        /// 🔵 LEFT ICON
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,

        /// 🔐 PASSWORD TOGGLE
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
        )
            : null,
      ),
    );
  }
}