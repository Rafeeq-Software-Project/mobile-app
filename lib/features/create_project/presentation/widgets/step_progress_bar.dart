import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      color: colors.grey0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step $currentStep of $totalSteps',
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: colors.primary800,
                ),
              ),
              Text(
                '${((currentStep / totalSteps) * 100).toInt()}%',
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: colors.grey600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: currentStep / totalSteps,
              backgroundColor: colors.grey200,
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary800),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}
