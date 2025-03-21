import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isObscured;
  const AuthTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.isObscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: isObscured,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          icon: Icon(icon),
          labelText: label,
        ),
      ),
    );
  }
}
