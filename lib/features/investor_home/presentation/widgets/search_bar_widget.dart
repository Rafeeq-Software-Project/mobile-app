import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Row(
      children: [
        // Search Field
        Expanded(
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: colors.grey0,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.grey300),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search startups by industry, st...',
                hintStyle: AppTextStyles.font14Regular.copyWith(
                  color: colors.grey400,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colors.grey500,
                  size: 22.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              onSubmitted: onSearch,
            ),
          ),
        ),
        SizedBox(width: 12.w),

        // Filter Button
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: colors.primary800,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary700.withValues(alpha: .3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              // Show filter bottom sheet
            },
            icon: Icon(Icons.tune, color: colors.grey0, size: 22.sp),
          ),
        ),
      ],
    );
  }
}
