import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class HomeAppBar extends StatelessWidget {
  final String userName;
  final VoidCallback onNotificationTap;

  const HomeAppBar({
    super.key,
    required this.userName,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: colors.grey0,
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
          // Profile Picture
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.primary800, width: 2),
            ),
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/150?img=33',
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning,',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: colors.grey600,
                  ),
                ),
                Text(
                  userName,
                  style: AppTextStyles.font16Bold.copyWith(
                    color: colors.grey900,
                  ),
                ),
              ],
            ),
          ),

          // Notification Icon
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
                    border: Border.all(color: colors.grey50, width: 1.5),
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
