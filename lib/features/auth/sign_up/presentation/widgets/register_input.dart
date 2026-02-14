import 'package:flutter/material.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';

class RegisterInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboard;
  final bool obscure;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const RegisterInput({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboard,
    this.obscure = false,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      hintText: hint,
      keyboardType: keyboard,
      isObscureText: obscure,
      suffixIcon: suffix,
      validator: validator ?? (v) => v!.isEmpty ? "Required" : null,
    );
  }
}
