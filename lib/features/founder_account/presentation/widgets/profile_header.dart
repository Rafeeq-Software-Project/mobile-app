import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_account/data/models/founder_profile.dart';

class ProfileHeader extends StatelessWidget {
  final FounderProfile founderProfile;

  const ProfileHeader({super.key, required this.founderProfile});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.primary800, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary700.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: colors.grey200,
                  backgroundImage:
                      (founderProfile.userProfilePictureUrl != null &&
                          founderProfile.userProfilePictureUrl!.isNotEmpty)
                      ? NetworkImage(founderProfile.userProfilePictureUrl!)
                      : null,
                  child:
                      (founderProfile.userProfilePictureUrl == null ||
                          founderProfile.userProfilePictureUrl!.isEmpty)
                      ? Icon(Icons.person, size: 40.sp, color: colors.grey500)
                      : null,
                ),
              ),
              Positioned(
                bottom: 4.h,
                right: 4.w,
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: colors.accent600,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.white, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Name with Verification Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                founderProfile.fullName,
                style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
              ),
              if (founderProfile.isProfileComplete) ...[
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: colors.primary800,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: colors.grey0, size: 12.sp),
                ),
              ],
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            founderProfile.companyName ?? " No company",
            style: AppTextStyles.font14Regular.copyWith(color: colors.grey600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: colors.primary300,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "Founder Account",
              style: AppTextStyles.font12Bold.copyWith(
                color: colors.primary800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
