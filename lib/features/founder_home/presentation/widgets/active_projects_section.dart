import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_home/data/models/dashboard_project_model.dart';
import 'project_list_item.dart';

class ActiveProjectsSection extends StatelessWidget {
  final List<DashboardProjectModel> projects;

  const ActiveProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Projects',
              style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'View All',
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: colors.primary800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Projects List
        Container(
          decoration: BoxDecoration(
            color: colors.grey50,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colors.grey300.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: projects.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: colors.grey200,
              indent: 16.w,
              endIndent: 16.w,
            ),
            itemBuilder: (context, index) {
              return ProjectListItem(
                project: projects[index],
                isLast: index == projects.length - 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
