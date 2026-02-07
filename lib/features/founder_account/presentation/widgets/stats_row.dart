import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class StatsRow extends StatelessWidget {
  final int projectsCount;
  final int successRate;

  const StatsRow({
    super.key,
    required this.projectsCount,
    required this.successRate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            context,
            label: 'Projects',
            value: projectsCount.toString(),
            colors: colors,
          ),
        ),
        Container(width: 1, height: 40.h, color: colors.grey300),
        Expanded(
          child: _buildStatItem(
            context,
            label: 'Deals',
            value: '12',
            colors: colors,
          ),
        ),
        Container(width: 1, height: 40.h, color: colors.grey300),
        Expanded(
          child: _buildStatItem(
            context,
            label: 'Success',
            value: '$successRate%',
            colors: colors,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String label,
    required String value,
    required CustomAppColors colors,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.font20Bold.copyWith(color: colors.grey800),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyles.font12Regular.copyWith(color: colors.grey600),
        ),
      ],
    );
  }
}
