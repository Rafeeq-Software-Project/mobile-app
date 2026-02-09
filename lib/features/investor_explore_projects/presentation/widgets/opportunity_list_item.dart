import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../data/models/explore_project_model.dart';

class OpportunityListItem extends StatelessWidget {
  final ExploreProjectModel project;
  final Function(String) onBookmarkToggle;
  final VoidCallback onTap;

  const OpportunityListItem({
    super.key,
    required this.project,
    required this.onBookmarkToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: colors.grey200,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.business, color: colors.grey500, size: 32.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.grey700.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          project.stage,
                          style: AppTextStyles.font12Bold.copyWith(
                            color: colors.accent600,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => onBookmarkToggle(project.id),
                        child: Icon(
                          project.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: project.isBookmarked
                              ? colors.primary800
                              : colors.grey400,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    project.title,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    project.description,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: colors.grey600,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        '\$${project.raisedAmount}M raised',
                        style: AppTextStyles.font12Bold.copyWith(
                          color: colors.grey700,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Target: \$${project.targetAmount > 0 ? project.targetAmount : 200}k',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: colors.grey600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
