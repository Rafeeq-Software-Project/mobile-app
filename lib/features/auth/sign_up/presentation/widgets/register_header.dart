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
        Text(
          "Create Your Account",
          style: AppTextStyles.font24Bold.copyWith(
            color: context.customAppColors.grey900,
          ),
        ),
        10.h.ph,
        Text(
          "Join the network and start your journey",
          textAlign: TextAlign.center,
          style: AppTextStyles.font16Regular.copyWith(
            color: context.customAppColors.grey600,
          ),
        ),
      ],
    );
  }
}
