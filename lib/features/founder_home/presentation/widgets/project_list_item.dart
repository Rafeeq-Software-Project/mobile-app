import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import '../../data/models/dashboard_project_model.dart';

class ProjectListItem extends StatelessWidget {
  final DashboardProjectModel project;
  final bool isLast;

  const ProjectListItem({
    super.key,
    required this.project,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(isLast ? 0 : 0),
        bottom: Radius.circular(isLast ? 16.r : 0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      project.statusColor,
                      colors,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: _getStatusColor(
                        project.statusColor,
                        colors,
                      ).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    project.status,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: _getStatusColor(project.statusColor, colors),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Info Row
            Row(
              children: [
                if (project.volunteers > 0) ...[
                  Icon(
                    Icons.people_outline_rounded,
                    size: 16.sp,
                    color: colors.grey600,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${project.volunteers} Volunteers',
                    style: AppTextStyles.font13Regular.copyWith(
                      color: colors.grey600,
                    ),
                  ),
                ],
                if (project.volunteers > 0 && project.dueDate.isNotEmpty) ...[
                  SizedBox(width: 12.w),
                  Container(
                    width: 3.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: colors.grey400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
                if (project.dueDate.isNotEmpty) ...[
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16.sp,
                    color: colors.grey600,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Due ${project.dueDate}',
                    style: AppTextStyles.font13Regular.copyWith(
                      color: colors.grey600,
                    ),
                  ),
                ],
              ],
            ),

            // Progress Bar
            if (project.progress > 0) ...[
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: project.progress,
                  backgroundColor: colors.grey200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getStatusColor(project.statusColor, colors),
                  ),
                  minHeight: 6.h,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String colorName, CustomAppColors colors) {
    switch (colorName) {
      case 'blue':
        return colors.primary800;
      case 'orange':
        return colors.warning500;
      case 'green':
        return colors.accent600;
      default:
        return colors.grey500;
    }
  }
}
