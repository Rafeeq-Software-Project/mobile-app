import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class AboutSection extends StatefulWidget {
  final String aboutMe;
  final List<String> skills;

  const AboutSection({super.key, required this.aboutMe, required this.skills});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      color: colors.grey0,
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'About Me',
                style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'Edit',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.primary800,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.edit_outlined,
                      size: 16.sp,
                      color: colors.primary800,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // About Text
          Text(
            widget.aboutMe,
            style: AppTextStyles.font14Regular.copyWith(
              color: colors.grey700,
              height: 1.5,
            ),
            maxLines: isExpanded ? null : 4,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
          if (widget.aboutMe.length > 150) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Show less' : 'Read more',
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: colors.primary800,
                ),
              ),
            ),
          ],
          SizedBox(height: 16.h),

          // Skills Tags
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: widget.skills.map((skill) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: colors.primary800.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: colors.primary800.withValues(alpha: .3),
                  ),
                ),
                child: Text(
                  skill,
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: colors.primary800,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
