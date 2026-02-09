import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class CategoryFilterChips extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    final categories = [
      {'label': 'All Sectors', 'icon': Icons.apps},
      {'label': 'Tech', 'icon': Icons.computer},
      {'label': 'Sustainability', 'icon': Icons.eco},
    ];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category['label'] == selectedCategory;

          return GestureDetector(
            onTap: () => onCategorySelected(category['label'] as String),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected ? colors.grey900 : colors.grey0,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? colors.grey900 : colors.grey300,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    color: isSelected ? colors.grey0 : colors.grey700,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    category['label'] as String,
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: isSelected ? colors.grey0 : colors.grey700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
