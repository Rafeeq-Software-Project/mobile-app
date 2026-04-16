import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutBack,
          child: Text(
            "Create Your Account",
            style: AppTextStyles.font24Bold.copyWith(
              color: context.customAppColors.grey900,
            ),
          ),
        ),
        10.h.ph,
        FadeIn(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 600),
          child: Text(
            "Join the network and start your journey",
            textAlign: TextAlign.center,
            style: AppTextStyles.font16Regular.copyWith(
              color: context.customAppColors.grey600,
            ),
          ),
        ),
      ],
    );
  }
}
