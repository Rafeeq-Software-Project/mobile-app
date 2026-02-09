import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ProjectInfoSection extends StatelessWidget {
  final String title;
  final String tagline;
  final String category;
  final String location;

  const ProjectInfoSection({
    super.key,
    required this.title,
    required this.tagline,
    required this.category,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.font24SemiBold.copyWith(color: colors.grey900),
        ),
        SizedBox(height: 4.h),
        Text(
          tagline,
          style: AppTextStyles.font14Regular.copyWith(color: colors.grey600),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: colors.primary800.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                category,
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: colors.primary800,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.location_on_outlined,
              size: 16.sp,
              color: colors.grey600,
            ),
            SizedBox(width: 4.w),
            Text(
              location,
              style: AppTextStyles.font12Regular.copyWith(
                color: colors.grey600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
