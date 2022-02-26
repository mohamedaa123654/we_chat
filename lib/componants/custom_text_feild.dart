import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild(
      {Key? key,
      this.hint,
      required this.label,
      this.suffix,
      this.prefix,
      this.isPassword = false})
      : super(key: key);
  final String? hint;
  final String label;
  final IconData? suffix;
  final IconData? prefix;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword!,
      decoration: InputDecoration(
          label: Text(label),
          labelStyle: TextStyle(color: Colors.white),
          suffix: Icon(suffix),
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefix),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}
