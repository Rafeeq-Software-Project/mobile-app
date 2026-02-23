import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class OtpAppBar extends StatelessWidget {
  final VoidCallback onBackTap;
  const OtpAppBar({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: colors.grey0,
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.grey900),
            onPressed: onBackTap,
          ),
          SizedBox(width: 8.w),
          Text(
            'Verify OTP',
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
          ),
        ],
      ),
    );
  }
}
