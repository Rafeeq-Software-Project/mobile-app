import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_home/data/models/opportunity_model.dart';

class OpportunityCard extends StatelessWidget {
  final OpportunityModel opportunity;
  final Function(String) onBookmarkToggle;

  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      width: 260.w,
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Container(
            height: 140.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getGradientColors(opportunity.imageUrl, colors),
              ),
            ),
            child: Stack(
              children: [
                // Pattern/Icon
                Center(
                  child: Icon(
                    _getIcon(opportunity.imageUrl),
                    size: 64.sp,
                    color: colors.grey0.withValues(alpha: 0.2),
                  ),
                ),
                // Tag
                if (opportunity.tag != null)
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getTagColor(opportunity.tag!, colors),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        opportunity.tag!,
                        style: AppTextStyles.font12Bold.copyWith(
                          color: colors.grey0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                // Bookmark Button
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Material(
                    color: colors.grey50,
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      onTap: () => onBookmarkToggle(opportunity.id),
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(
                          opportunity.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: opportunity.isBookmarked
                              ? colors.primary800
                              : colors.grey600,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    opportunity.title,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: colors.grey900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),

                  // Subtitle
                  Text(
                    '${opportunity.company} • ${opportunity.location}',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: colors.grey600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // Due Date & Equity
                  Row(
                    children: [
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
                          opportunity.dueDate,
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: colors.grey700,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
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
                          opportunity.equity,
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: colors.grey700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Divider
                  Divider(height: 1, color: colors.grey200),
                  SizedBox(height: 8.h),

                  // Explore Button
                  SizedBox(
                    width: double.infinity,
                    height: 36.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary800,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Explore',
                        style: AppTextStyles.font14SemiBold.copyWith(
                          color: colors.grey0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getGradientColors(String imageUrl, CustomAppColors colors) {
    if (imageUrl == 'greentech') {
      return [const Color(0xFF006064), const Color(0xFF00838F)];
    } else if (imageUrl == 'medical') {
      return [const Color(0xFF6A1B9A), const Color(0xFF8E24AA)];
    }
    return [colors.primary700, colors.primary500];
  }

  IconData _getIcon(String imageUrl) {
    if (imageUrl == 'greentech') return Icons.eco;
    if (imageUrl == 'medical') return Icons.medical_services;
    return Icons.business;
  }

  Color _getTagColor(String tag, CustomAppColors colors) {
    if (tag == 'SEED A') return const Color(0xFF00897B);
    if (tag == 'URGENT') return colors.error500;
    return colors.primary700;
  }
}
