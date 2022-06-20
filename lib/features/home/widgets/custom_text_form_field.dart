import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool validator;
  final bool? autofocus;
  final String label;
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? initialValue;
  // final Widget? suffixIcon;
  // final bool? suffixIconBool;
  const CustomTextFormField({
    super.key,
    this.keyboardType,
    this.validator = true,
    this.maxLines = 1,
    required this.label,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.onSaved,
    this.autofocus = false,

    // this.suffixIcon,
    // this.suffixIconBool = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // onTap: () => controller!.selection = TextSelection(
      //     baseOffset: 0, extentOffset: controller!.value.text.length),
      autofocus: true,
      onSaved: onSaved,
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator
          ? ((value) => value!.isEmpty ? "please enter $label" : null)
          : null,
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
