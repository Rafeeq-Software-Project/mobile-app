import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class CustomProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String subtitle;
  final String memberSince;
  final bool isVerified;

  const CustomProfileHeader({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    required this.memberSince,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.customAppColors.grey300,
                image: imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: context.customAppColors.primary800,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.customAppColors.grey0,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.edit,
                  color: context.customAppColors.grey0,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Name with Verification Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: AppTextStyles.font20SemiBold.copyWith(
                color: context.customAppColors.grey900,
              ),
            ),
            if (isVerified) ...[
              SizedBox(width: 6.w),
              Icon(Icons.verified, color: Colors.green, size: 20.sp),
            ],
          ],
        ),

        SizedBox(height: 4.h),

        // Subtitle
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            color: context.customAppColors.primary700,
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(height: 2.h),

        // Member Since
        Text(
          memberSince,
          style: AppTextStyles.font12Regular.copyWith(
            color: context.customAppColors.grey600,
          ),
        ),
      ],
    );
  }
}
