import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class DashboardAppBar extends StatelessWidget {
  final String userName;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;

  const DashboardAppBar({
    super.key,
    required this.userName,
    required this.onNotificationTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: colors.background,
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo and App Name
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary800, colors.primary500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: colors.primary800.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.volunteer_activism_rounded,
              color: colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Rafeeq',
            style: AppTextStyles.font20SemiBold.copyWith(color: colors.grey900),
          ),
          const Spacer(),

          // Search Icon
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: colors.grey700, size: 24.sp),
          ),
          SizedBox(width: 4.w),

          // Notification Icon with Badge
          Stack(
            children: [
              IconButton(
                onPressed: onNotificationTap,
                icon: Icon(
                  Icons.notifications_outlined,
                  color: colors.grey700,
                  size: 24.sp,
                ),
              ),
              Positioned(
                right: 10.w,
                top: 10.h,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: colors.error500,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 4.w),

          // Profile Picture
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colors.primary800, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: colors.primary800.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 20.r,
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
