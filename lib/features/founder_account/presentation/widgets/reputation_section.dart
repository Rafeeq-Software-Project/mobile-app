import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/features/founder_account/data/models/user_profile_model.dart';

class ReputationSection extends StatelessWidget {
  final ReputationModel reputation;

  const ReputationSection({super.key, required this.reputation});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      color: colors.grey0,
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Reputation',
            style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 20.h),

          // Rating Overview
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overall Rating
              Column(
                children: [
                  Text(
                    reputation.overallRating.toStringAsFixed(1),
                    style: AppTextStyles.font48Bold.copyWith(
                      color: colors.grey900,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < reputation.overallRating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: colors.warning500,
                        size: 20.sp,
                      );
                    }),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${reputation.totalReviews} Reviews',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: colors.grey600,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 32.w),

              // Rating Breakdown
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar(context, 5, reputation, colors),
                    SizedBox(height: 8.h),
                    _buildRatingBar(context, 4, reputation, colors),
                    SizedBox(height: 8.h),
                    _buildRatingBar(context, 3, reputation, colors),
                    SizedBox(height: 8.h),
                    _buildRatingBar(context, 2, reputation, colors),
                    SizedBox(height: 8.h),
                    _buildRatingBar(context, 1, reputation, colors),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // View All Reviews Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colors.grey300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'View All Reviews',
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: colors.grey800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(
    BuildContext context,
    int stars,
    ReputationModel reputation,
    CustomAppColors colors,
  ) {
    final percentage = reputation.getRatingPercentage(stars);

    return Row(
      children: [
        // Star number
        Text(
          '$stars',
          style: AppTextStyles.font12Regular.copyWith(color: colors.grey700),
        ),
        SizedBox(width: 8.w),

        // Progress bar
        Expanded(
          child: Stack(
            children: [
              // Background
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: colors.grey400,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              // Fill
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.accent600,
                        colors.accent600.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),

        // Percentage
        SizedBox(
          width: 32.w,
          child: Text(
            '$percentage%',
            style: AppTextStyles.font12Regular.copyWith(color: colors.grey600),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
