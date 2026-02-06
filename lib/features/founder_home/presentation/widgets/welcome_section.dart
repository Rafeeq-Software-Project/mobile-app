import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class WelcomeSection extends StatelessWidget {
  final String userName;

  const WelcomeSection({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Welcome back, $userName!',
              style: AppTextStyles.font24Bold.copyWith(color: colors.grey900),
            ),
            SizedBox(width: 8.w),
            Text('👋', style: TextStyle(fontSize: 24.sp)),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          'Here is what\'s happening with your ventures today.',
          style: AppTextStyles.font14Regular.copyWith(
            color: colors.grey600,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
