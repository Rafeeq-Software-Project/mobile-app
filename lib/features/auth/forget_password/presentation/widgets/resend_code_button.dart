import 'package:flutter/material.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class ResendCodeButton extends StatelessWidget {
  final bool canResend;
  final int countdown;
  final VoidCallback onResend;

  const ResendCodeButton({
    super.key,
    required this.canResend,
    required this.countdown,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive the code? ",
          style: AppTextStyles.font14Regular.copyWith(color: colors.grey600),
        ),
        if (canResend)
          GestureDetector(
            onTap: onResend,
            child: Text(
              'Resend',
              style: AppTextStyles.font14Bold.copyWith(
                color: colors.primary700,
              ),
            ),
          )
        else
          Text(
            'Resend in ${countdown}s',
            style: AppTextStyles.font14Regular.copyWith(color: colors.grey500),
          ),
      ],
    );
  }
}
