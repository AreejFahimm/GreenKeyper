import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final IconData? trailing;
  final bool dense;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const LabeledField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.obscure,
    this.trailing,
    this.dense = false,
    this.readOnly = false,
    this.keyboardType,
    this.controller,
  });

  const LabeledField.compact({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.obscure,
    this.trailing,
    this.readOnly = false,
    this.keyboardType,
    this.controller,
  }) : dense = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          readOnly: readOnly,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: trailing != null ? Icon(trailing) : null,
            isDense: dense,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
