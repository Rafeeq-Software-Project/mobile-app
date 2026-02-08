import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_home/data/models/opportunity_model.dart';
import 'opportunity_list_item.dart';

class RecentOpportunitiesSection extends StatelessWidget {
  final List<OpportunityModel> opportunities;
  final Function(String) onBookmarkToggle;

  const RecentOpportunitiesSection({
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
          child: Text(
            'Recent Opportunities',
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
          ),
        ),
        SizedBox(height: 16.h),
        // List Items
        Container(
          color: colors.grey0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: opportunities.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(8.h),
              child: Divider(height: 1, color: colors.grey200, indent: 72.w),
            ),
            itemBuilder: (context, index) {
              return OpportunityListItem(
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
