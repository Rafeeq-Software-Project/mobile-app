import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ExploreAppBar extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onBookmarkTap;

  const ExploreAppBar({
    super.key,
    required this.onNotificationTap,
    required this.onBookmarkTap,
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
          Text(
            'Explore Projects',
            style: AppTextStyles.font18SemiBold.copyWith(color: colors.grey900),
          ),
          const Spacer(),
          IconButton(
            onPressed: onBookmarkTap,
            icon: Icon(
              Icons.bookmark_border,
              color: colors.grey700,
              size: 24.sp,
            ),
          ),
          IconButton(
            onPressed: onNotificationTap,
            icon: Icon(
              Icons.notifications_outlined,
              color: colors.grey700,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
