import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class FundingTypeCard extends StatelessWidget {
  final String type;
  final String description;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const FundingTypeCard({
    super.key,
    required this.type,
    required this.description,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: .1) : colors.grey0,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : colors.grey300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            SizedBox(width: 16.w),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: colors.grey600,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),

            // Selection indicator
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : colors.grey400,
                  width: 2,
                ),
                color: isSelected ? color : colors.grey0,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 14.sp, color: colors.grey0)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
