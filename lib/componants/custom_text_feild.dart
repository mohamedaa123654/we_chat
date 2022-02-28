import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.hint,
      required this.label,
      this.suffix,
      this.prefix,
      this.isPassword = false,
      this.onChanged,
      this.keyboardType})
      : super(key: key);
  final String? hint;
  final String label;
  final TextInputType? keyboardType;
  final IconData? suffix;
  final IconData? prefix;
  final bool? isPassword;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword!,
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      style: TextStyle(
        color: Colors.white,
      ),
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
