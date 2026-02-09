import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class PitchSection extends StatefulWidget {
  final String pitch;
  const PitchSection({super.key, required this.pitch});
  @override
  State<PitchSection> createState() => _PitchSectionState();
}

class _PitchSectionState extends State<PitchSection> {
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
          Text(
            'The Pitch',
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 12.h),
          Text(
            widget.pitch,
            style: AppTextStyles.font14Regular.copyWith(
              color: colors.grey700,
              height: 1.5,
            ),
            maxLines: isExpanded ? null : 4,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
          if (widget.pitch.length > 200) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Row(
                children: [
                  Text(
                    isExpanded ? 'Read Less' : 'Read More',
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: colors.primary800,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16.sp,
                    color: colors.primary800,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
