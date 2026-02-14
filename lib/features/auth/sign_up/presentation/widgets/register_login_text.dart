import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class RegisterLoginText extends StatelessWidget {
  const RegisterLoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?", style: AppTextStyles.font14Regular),
        TextButton(
          onPressed: () => GoRouter.of(context).push(Routes.login),
          child: Text(
            "Sign In",
            style: TextStyle(
              color: context.customAppColors.primary700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
