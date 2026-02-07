import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onNewProject;

  const ActionButtonsRow({
    super.key,
    required this.onShare,
    required this.onNewProject,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colors.grey0,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.grey400.withValues(alpha: .4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildActionButton(
              context,
              icon: Icons.share_outlined,
              label: 'Share Profile',
              onTap: onShare,
              isPrimary: false,
              colors: colors,
            ),
          ),
          SizedBox(width: 8.w),
          // New Project Button
          Expanded(
            flex: 3,
            child: _buildActionButton(
              context,
              icon: Icons.add_circle_outline,
              label: 'New Project',
              onTap: onNewProject,
              isPrimary: true,
              colors: colors,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
    required CustomAppColors colors,
  }) {
    return Material(
      color: isPrimary ? colors.accent600 : colors.grey50,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            border: isPrimary
                ? null
                : Border.all(color: colors.grey300, width: 1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary ? colors.white : colors.grey700,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: isPrimary ? colors.white : colors.grey800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
