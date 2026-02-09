import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../data/models/explore_project_model.dart';

class TrendingProjectCard extends StatelessWidget {
  final ExploreProjectModel project;
  final Function(String) onBookmarkToggle;
  final VoidCallback onTap;

  const TrendingProjectCard({
    super.key,
    required this.project,
    required this.onBookmarkToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280.w,
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
            Stack(
              children: [
                Container(
                  height: 140.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF757575),
                        const Color(0xFF9E9E9E),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.business_center,
                      size: 48.sp,
                      color: colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),

                // Trending Badge
                if (project.isTrending)
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.warning500,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            size: 14.sp,
                            color: colors.white,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Trending',
                            style: AppTextStyles.font12Bold.copyWith(
                              color: colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Bookmark
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Material(
                    color: colors.grey50.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      onTap: () => onBookmarkToggle(project.id),
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(
                          project.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: project.isBookmarked
                              ? colors.primary800
                              : colors.grey600,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),

                // Stage Badge
                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary800,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      project.stage,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      project.title,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: colors.grey900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),

                    // Description
                    Text(
                      project.description,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.grey600,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Tags
                    Row(
                      children: project.tags.map((tag) {
                        return Container(
                          margin: EdgeInsets.only(right: 8.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.grey100,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            tag,
                            style: AppTextStyles.font12SemiBold.copyWith(
                              color: colors.grey700,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12.h),

                    // Progress
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: project.fundingProgress / 100,
                        backgroundColor: colors.grey200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colors.primary800,
                        ),
                        minHeight: 6.h,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Founders and Button
                    Row(
                      children: [
                        // Founders Avatars
                        if (project.founders.isNotEmpty)
                          SizedBox(
                            width: 60.w,
                            height: 24.h,
                            child: Stack(
                              children: List.generate(
                                project.founders.length.clamp(0, 2),
                                (index) => Positioned(
                                  left: index * 20.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 12.r,
                                      backgroundImage: NetworkImage(
                                        project.founders[index].imageUrl,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (project.founders.length > 2)
                          Text(
                            '+${project.founders.length - 2}',
                            style: AppTextStyles.font12Regular.copyWith(
                              color: colors.grey600,
                            ),
                          ),
                        const Spacer(),

                        // View Details
                        TextButton(
                          onPressed: onTap,
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
            ),
          ],
        ),
      ),
    );
  }
}
