import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import '../../../../core/theme/app_texts/app_text_styles.dart';
import 'status_badge.dart';
import 'progress_bar.dart';
import 'action_link.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    if (project.isDraft) {
      return _buildDraftCard(context, colors);
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Status and Category
          Row(
            children: [
              StatusBadge(
                label: project.status,
                color: _getStatusColor(project.statusColor, colors),
              ),
              SizedBox(width: 8.w),
              StatusBadge(
                label: project.category,
                color: colors.grey200,
                textColor: colors.grey700,
              ),
              const Spacer(),
              // Project Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  project.imageUrl,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: colors.grey200,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.image, color: colors.grey500),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Title
          Text(
            project.title,
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 6.h),

          // Description
          Text(
            project.description,
            style: AppTextStyles.font13Regular.copyWith(
              color: colors.grey600,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.h),

          // Funding Info
          if (!project.isDraft) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${_formatAmount(project.raisedAmount)}',
                  style: AppTextStyles.font14Bold.copyWith(color: colors.black),
                ),
                Text(
                  'Goal: \$${_formatAmount(project.goalAmount)}',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: colors.grey600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Progress Bar
            ProgressBar(
              percentage: project.fundingPercentage,
              color: _getStatusColor(project.statusColor, colors),
            ),
            SizedBox(height: 12.h),
          ],

          // Bottom Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                project.statusLabel,
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: _getStatusColor(project.statusColor, colors),
                ),
              ),
              ActionLink(
                label: project.status == 'Funded' ? 'Manage' : 'Details',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDraftCard(BuildContext context, CustomAppColors colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colors.grey300,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusBadge(
                label: project.status,
                color: colors.grey200,
                textColor: colors.grey600,
              ),
              SizedBox(width: 8.w),
              StatusBadge(
                label: project.category,
                color: colors.grey100,
                textColor: colors.grey600,
              ),
              const Spacer(),
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: colors.grey100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.image_outlined,
                  color: colors.grey400,
                  size: 28.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            project.title,
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey700),
          ),
          SizedBox(height: 6.h),
          Text(
            project.description,
            style: AppTextStyles.font13Regular.copyWith(color: colors.grey500),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                project.statusLabel,
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.grey500,
                ),
              ),
              ActionLink(label: 'Resume Edit', onTap: () {}, icon: Icons.edit),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String colorName, CustomAppColors colors) {
    switch (colorName) {
      case 'green':
        return colors.accent600;
      case 'orange':
        return colors.warning500;
      case 'blue':
        return colors.primary800;
      default:
        return colors.grey500;
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}k';
    }
    return amount.toStringAsFixed(0);
  }
}
