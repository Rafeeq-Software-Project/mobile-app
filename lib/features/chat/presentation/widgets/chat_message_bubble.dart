import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMyMessage;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMyMessage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Align(
      alignment: isMyMessage ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment: isMyMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            constraints: BoxConstraints(maxWidth: 280.w),
            decoration: BoxDecoration(
              color: isMyMessage ? colors.grey100 : colors.primary800,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: isMyMessage ? colors.grey900 : colors.white,
                  ),
                ),
              ],
            ),
          ),
          2.h.ph,
          Text(
            time,
            style: AppTextStyles.font12Regular.copyWith(color: colors.grey400),
          ),
        ],
      ),
    );
  }
}
