import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class StatsCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const StatsCard({
    super.key,
    required this.count,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                count,
                style: AppTextStyles.font32Bold.copyWith(color: colors.black),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: AppTextStyles.font12Regular.copyWith(
              color: colors.grey600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
