import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ConversationListItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final bool hasUnread;
  final VoidCallback? onTap;

  const ConversationListItem({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    this.hasUnread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.grey100, width: 1)),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundImage: AssetImage(avatarUrl),
                ),
                if (hasUnread)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: colors.error500,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.font16SemiBold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    lastMessage,
                    style: AppTextStyles.font14Regular.copyWith(
                      color: colors.grey500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              time,
              style: AppTextStyles.font12Regular.copyWith(
                color: colors.grey400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
