import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.grey100,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colors.grey300, width: 1),
      ),
      child: Text(
        label,
        style: AppTextStyles.font12Regular.copyWith(color: colors.grey800),
      ),
    );
  }
}
