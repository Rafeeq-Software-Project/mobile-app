import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'tag_chip.dart';
import 'action_button.dart';

class RequestCard extends StatelessWidget {
  final String name;
  final String role;
  final String profileImage;
  final bool isVerified;
  final double rating;
  final String yearsActive;
  final String dealsCount;
  final List<String> tags;

  const RequestCard({
    super.key,
    required this.name,
    required this.role,
    required this.profileImage,
    required this.isVerified,
    required this.rating,
    required this.yearsActive,
    required this.dealsCount,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.grey200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Row(
            children: [
              // Profile Image
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  if (isVerified)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: colors.primary800,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: colors.white,
                            size: 10.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.w),

              // Name and Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      role,
                      style: AppTextStyles.font13Regular.copyWith(
                        color: colors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: colors.warning500.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: colors.warning500, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      rating.toString(),
                      style: AppTextStyles.font12Bold.copyWith(
                        color: colors.warning500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.access_time, size: 14.sp, color: colors.accent600),
              SizedBox(width: 4.w),
              Text(
                yearsActive,
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.grey700,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.description_outlined,
                size: 14.sp,
                color: colors.grey600,
              ),
              SizedBox(width: 4.w),
              Text(
                dealsCount,
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.grey700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Tags
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: tags.map((tag) => TagChip(label: tag)).toList(),
          ),
          SizedBox(height: 16.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  label: 'Profile',
                  isOutlined: true,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ActionButton(
                  label: 'Reject',
                  isOutlined: true,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ActionButton(
                  label: 'Accept',
                  isOutlined: false,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
