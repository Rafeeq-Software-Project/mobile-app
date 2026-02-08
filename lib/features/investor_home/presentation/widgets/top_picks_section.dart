import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_home/data/models/opportunity_model.dart';
import 'opportunity_card.dart';

class TopPicksSection extends StatelessWidget {
  final List<OpportunityModel> opportunities;
  final Function(String) onBookmarkToggle;

  const TopPicksSection({
    super.key,
    required this.opportunities,
    required this.onBookmarkToggle,
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
                'Top Picks for You',
                style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
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

        // Horizontal List
        SizedBox(
          height: 320.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: opportunities.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return OpportunityCard(
                opportunity: opportunities[index],
                onBookmarkToggle: onBookmarkToggle,
              );
            },
          ),
        ),
      ],
    );
  }
}
