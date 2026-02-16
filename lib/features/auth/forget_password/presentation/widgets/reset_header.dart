import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class ResetHeader extends StatelessWidget {
  const ResetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Column(
      children: [
        // Lock Icon with gradient background
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF00838F), const Color(0xFF00ACC1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00ACC1).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.lock_reset, size: 40.sp, color: colors.white),
        ),
        SizedBox(height: 24.h),

        // Title
        Text(
          'Create new password',
          style: AppTextStyles.font20Bold.copyWith(color: colors.black),
        ),
        SizedBox(height: 8.h),

        // Description
        Text(
          'Your new password must be different from\npreviously used passwords.',
          style: AppTextStyles.font14Regular.copyWith(
            color: colors.grey600,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
