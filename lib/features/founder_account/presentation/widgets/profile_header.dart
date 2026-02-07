import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ProfileHeader extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String location;
  final bool isVerified;
  final int followers;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  const ProfileHeader({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.location,
    required this.isVerified,
    required this.followers,
    required this.isFollowing,
    required this.onFollowToggle,
  });

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
                  backgroundImage: NetworkImage(profileImageUrl),
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
                name,
                style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
              ),
              if (isVerified) ...[
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

          // Location
          Text(
            location,
            style: AppTextStyles.font14Regular.copyWith(color: colors.grey600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),

          // Followers Count with Follow Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 16.sp, color: colors.grey600),
              SizedBox(width: 4.w),
              Text(
                '$followers',
                style: AppTextStyles.font14Bold.copyWith(color: colors.grey900),
              ),
              SizedBox(width: 4.w),
              Text(
                'Followers',
                style: AppTextStyles.font14Regular.copyWith(
                  color: colors.grey600,
                ),
              ),
              SizedBox(width: 12.w),

              // Follow/Following Button
              GestureDetector(
                onTap: onFollowToggle,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isFollowing
                        ? colors.grey200
                        : colors.primary800.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isFollowing ? colors.grey400 : colors.primary800,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isFollowing ? Icons.check : Icons.add,
                        size: 14.sp,
                        color: isFollowing ? colors.grey700 : colors.primary800,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        isFollowing ? 'Following' : 'Follow',
                        style: AppTextStyles.font12SemiBold.copyWith(
                          color: isFollowing
                              ? colors.grey700
                              : colors.primary800,
                        ),
                      ),
                    ],
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
