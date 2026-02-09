import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../data/models/explore_project_model.dart';

class DealHighlightsSection extends StatelessWidget {
  final List<DealHighlight> highlights;
  const DealHighlightsSection({super.key, required this.highlights});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      color: colors.grey0,
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deal Highlights',
            style: AppTextStyles.font18SemiBold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 2,
            ),
            itemCount: highlights.length,
            itemBuilder: (c, i) => Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.grey50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.grey200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIcon(highlights[i].icon),
                    size: 24.sp,
                    color: colors.primary800,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    highlights[i].label,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: colors.grey900,
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

  IconData _getIcon(String icon) {
    switch (icon) {
      case 'users':
        return Icons.people_outline;
      case 'chart':
        return Icons.trending_up;
      case 'equity':
        return Icons.pie_chart_outline;
      case 'safe':
        return Icons.shield_outlined;
      default:
        return Icons.star_outline;
    }
  }
}
