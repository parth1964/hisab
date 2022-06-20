import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool autofocus;
  final bool obscureText;
  final String label;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? initialValue;

  const CustomTextFormField({
    super.key,
    this.keyboardType,
    required this.label,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.onSaved,
    this.autofocus = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      autofocus: autofocus,
      onSaved: onSaved,
      initialValue: initialValue,
      validator: (value) => value!.isEmpty ? "please enter $label" : null,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // suffixIcon: suffixIconBool == false ? null : suffixIcon,
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
    );
  }
}
