import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.obscureText = false,
    this.prefix,
  });

  final TextEditingController controller;
  final String placeholder;
  final bool obscureText;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Color(0xFFF9FAFA),
          ),
        ),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 16,
        ),
        prefixIcon: prefix,
      ),
    );
  }
}
