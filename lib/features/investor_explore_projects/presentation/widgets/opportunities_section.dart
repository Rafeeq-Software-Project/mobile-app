import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../data/models/explore_project_model.dart';
import 'opportunity_list_item.dart';

class OpportunitiesSection extends StatelessWidget {
  final List<ExploreProjectModel> projects;
  final Function(String) onBookmarkToggle;
  final Function(ExploreProjectModel) onProjectTap;

  const OpportunitiesSection({
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Opportunities',
                style: AppTextStyles.font18SemiBold.copyWith(
                  color: colors.grey900,
                ),
              ),
              DropdownButton<String>(
                value: 'Newest',
                underline: SizedBox(),
                items: ['Newest', 'Popular', 'Trending']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) {},
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          color: colors.grey0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            separatorBuilder: (c, i) =>
                Divider(height: 1, color: colors.grey200),
            itemBuilder: (c, i) => OpportunityListItem(
              project: projects[i],
              onBookmarkToggle: onBookmarkToggle,
              onTap: () => onProjectTap(projects[i]),
            ),
          ),
        ),
      ],
    );
  }
}
