import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class CategoryChips extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    final categories = ['All', 'Fintech', 'Health', 'SaaS', 'AI/ML'];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected ? colors.primary800 : colors.grey50,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? colors.primary800 : colors.grey300,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colors.primary800.withValues(alpha: .2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                category,
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: isSelected ? colors.grey0 : colors.grey700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
