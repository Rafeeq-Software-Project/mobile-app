import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';

class ChatHeader extends StatelessWidget {
  final String name;
  final String subtitle;
  final String avatarUrl;

  const ChatHeader({
    super.key,
    required this.name,
    required this.subtitle,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colors.primary800,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundImage: AssetImage(avatarUrl),
                    ),
                    12.w.pw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.font16Bold.copyWith(
                            color: colors.white,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: colors.white.withValues(alpha: .9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildActionButton(AppIcons.callIcon, colors),
                    SizedBox(width: 8.w),
                    _buildActionButton(AppIcons.videoIcon, colors),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String icon, CustomAppColors colors) {
    return Container(
      height: 42.h,
      width: 42.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(child: SvgPicture.asset(icon)),
    );
  }
}
