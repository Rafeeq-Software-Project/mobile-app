import 'package:flutter/material.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Find your next\n',
                style: AppTextStyles.font24Bold.copyWith(
                  color: colors.grey900,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: 'unicorn',
                style: AppTextStyles.font24Bold.copyWith(
                  color: colors.primary700,
                  height: 1.3,
                ),
              ),
              TextSpan(
                text: '.',
                style: AppTextStyles.font24Bold.copyWith(
                  color: colors.black,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
