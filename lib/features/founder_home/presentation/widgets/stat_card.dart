import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../data/models/stats_model.dart';

class StatCard extends StatelessWidget {
  final StatsModel stat;

  const StatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: stat.isHighlighted ? colors.primary800 : colors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: stat.isHighlighted ? colors.primary800 : colors.grey200,
        ),
        boxShadow: [
          BoxShadow(
            color: stat.isHighlighted
                ? colors.primary700.withValues(alpha: .15)
                : colors.grey100.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label
          Text(
            stat.label,
            style: AppTextStyles.font12Regular.copyWith(
              color: stat.isHighlighted
                  ? colors.grey0.withValues(alpha: 0.9)
                  : colors.grey600,
              letterSpacing: 0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),

          // Value and Change
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  stat.value,
                  style: AppTextStyles.font24Bold.copyWith(
                    color: stat.isHighlighted ? colors.grey0 : colors.grey900,
                    height: 1.0,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: stat.isHighlighted
                      ? colors.grey0.withValues(alpha: 0.2)
                      : colors.accent600.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  stat.changePercentage,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: stat.isHighlighted ? colors.grey0 : colors.accent600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
