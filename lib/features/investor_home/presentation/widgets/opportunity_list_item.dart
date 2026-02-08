import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import '../../data/models/opportunity_model.dart';

class OpportunityListItem extends StatelessWidget {
  final OpportunityModel opportunity;
  final Function(String) onBookmarkToggle;

  const OpportunityListItem({
    super.key,
    required this.opportunity,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return InkWell(
      onTap: () {
        // Navigate to details
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(opportunity.company, colors),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _getIcon(opportunity.company),
                color: colors.grey0,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Industry
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          opportunity.title,
                          style: AppTextStyles.font16Bold.copyWith(
                            color: colors.grey900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Bookmark Button
                      GestureDetector(
                        onTap: () => onBookmarkToggle(opportunity.id),
                        child: Icon(
                          opportunity.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: opportunity.isBookmarked
                              ? colors.primary800
                              : colors.grey400,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Industry
                  Row(
                    children: [
                      Text(
                        opportunity.company,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: colors.grey600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 3.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: colors.grey400,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        opportunity.industry,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: colors.grey600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Description
                  Text(
                    opportunity.description,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: colors.grey700,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),

                  // Stats and Action
                  Row(
                    children: [
                      // Equity
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.accent600.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          opportunity.equity,
                          style: AppTextStyles.font12Bold.copyWith(
                            color: colors.accent600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // Salary
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.grey100,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          opportunity.salary,
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: colors.grey700,
                          ),
                        ),
                      ),
                      const Spacer(),

                      // View Details Button
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Details',
                              style: AppTextStyles.font12SemiBold.copyWith(
                                color: colors.primary800,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward,
                              size: 14.sp,
                              color: colors.primary800,
                            ),
                          ],
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

  Color _getIconBackgroundColor(String company, CustomAppColors colors) {
    switch (company.toLowerCase()) {
      case 'fintech':
        return const Color(0xFFFF6F00);
      case 'edtech':
        return const Color(0xFF7B1FA2);
      case 'supply chain':
        return const Color(0xFF1976D2);
      default:
        return colors.primary800;
    }
  }

  IconData _getIcon(String company) {
    switch (company.toLowerCase()) {
      case 'fintech':
        return Icons.account_balance;
      case 'edtech':
        return Icons.school;
      case 'supply chain':
        return Icons.local_shipping;
      default:
        return Icons.business;
    }
  }
}
