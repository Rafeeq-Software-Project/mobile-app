import 'package:flutter/material.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customAppColors.background,
      body: const SafeArea(child: RegisterForm()),
    );
  }
}
