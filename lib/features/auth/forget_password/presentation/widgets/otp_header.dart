import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class OtpHeader extends StatelessWidget {
  final String email;
  const OtpHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Column(
      children: [
        // Lock Icon
        Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary700, colors.primary500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary700.withValues(alpha: .3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.mail_outline, size: 48.sp, color: colors.white),
        ),
        SizedBox(height: 24.h),

        // Title
        Text(
          'Verify your email',
          style: AppTextStyles.font24Bold.copyWith(color: colors.black),
        ),
        SizedBox(height: 12.h),

        // Description
        Text(
          'We\'ve sent a 6-digit verification code to',
          style: AppTextStyles.font14Regular.copyWith(color: colors.grey600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          email,
          style: AppTextStyles.font14Bold.copyWith(color: colors.primary700),
        ),
        SizedBox(height: 8.h),
        Text(
          'Please enter the code below',
          style: AppTextStyles.font14Regular.copyWith(color: colors.grey600),
        ),
      ],
    );
  }
}
