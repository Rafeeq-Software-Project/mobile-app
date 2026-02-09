import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_explore_projects/data/models/explore_project_model.dart';
import 'trending_project_card.dart';

class TrendingSection extends StatelessWidget {
  final List<ExploreProjectModel> projects;
  final Function(String) onBookmarkToggle;
  final Function(ExploreProjectModel) onProjectTap;

  const TrendingSection({
    super.key,
    required this.projects,
    required this.onBookmarkToggle,
    required this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Now',
                style: AppTextStyles.font18SemiBold.copyWith(
                  color: colors.grey900,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.primary800,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: colors.primary800,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Trending Cards
        SizedBox(
          height: 330.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: projects.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return TrendingProjectCard(
                project: projects[index],
                onBookmarkToggle: onBookmarkToggle,
                onTap: () => onProjectTap(projects[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
