import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_saved_projects/data/models/saved_project_model.dart';

class SavedAppBar extends StatelessWidget {
  final VoidCallback onBackTap, onSearchTap;
  const SavedAppBar({
    super.key,
    required this.onBackTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(color: colors.grey0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.grey900),
            onPressed: onBackTap,
          ),
          Expanded(
            child: Text(
              'Saved Projects',
              style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: colors.grey900),
            onPressed: onSearchTap,
          ),
        ],
      ),
    );
  }
}

class CategoryTabs extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;
  const CategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final categories = ['All', 'Tech', 'Health', 'Retail'];
    return Container(
      color: colors.grey0,
      height: 48.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        itemCount: categories.length,
        separatorBuilder: (c, i) => SizedBox(width: 8.w),
        itemBuilder: (c, i) {
          final category = categories[i];
          final isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () => onCategoryChanged(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected ? colors.grey900 : colors.grey0,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? colors.grey900 : colors.grey300,
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: isSelected ? colors.grey0 : colors.grey700,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SavedProjectCard extends StatelessWidget {
  final SavedProjectModel project;
  final Function(String) onToggleSaved;
  final VoidCallback onTap;
  const SavedProjectCard({
    super.key,
    required this.project,
    required this.onToggleSaved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.grey50,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: colors.grey300.withValues(alpha: .2),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                    gradient: _getGradient(project.imageUrl),
                  ),
                  child: Center(
                    child: Icon(
                      _getIcon(project.imageUrl),
                      size: 48.sp,
                      color: colors.grey0.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () => onToggleSaved(project.id),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: colors.white.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        project.isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: project.isSaved
                            ? colors.primary800
                            : colors.grey600,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.grey100,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        project.category,
                        style: AppTextStyles.font12Bold.copyWith(
                          color: colors.grey700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      project.name,
                      style: AppTextStyles.font14Bold.copyWith(
                        color: colors.grey900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          'Raised',
                          style: AppTextStyles.font12Regular.copyWith(
                            color: colors.grey600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${project.fundingProgress}%',
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: colors.grey700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          project.raisedAmount < 1
                              ? '\$${project.raisedAmount}M'
                              : '\$${project.raisedAmount}k',
                          style: AppTextStyles.font12Bold.copyWith(
                            color: colors.grey900,
                          ),
                        ),
                        if (project.targetAmount > 0) ...[
                          Text(
                            ' / ',
                            style: AppTextStyles.font12Regular.copyWith(
                              color: colors.grey500,
                            ),
                          ),
                          Text(
                            '\$${project.targetAmount}M',
                            style: AppTextStyles.font12Regular.copyWith(
                              color: colors.grey500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 6.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.r),
                      child: LinearProgressIndicator(
                        value: project.fundingProgress / 100,
                        backgroundColor: colors.grey200,
                        valueColor: AlwaysStoppedAnimation(colors.primary800),
                        minHeight: 4.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _getGradient(String img) {
    if (img == 'eco')
      return LinearGradient(colors: [Color(0xFF00ACC1), Color(0xFF00838F)]);
    if (img == 'medical')
      return LinearGradient(colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)]);
    if (img == 'agro')
      return LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)]);
    if (img == 'robotics')
      return LinearGradient(colors: [Color(0xFF1976D2), Color(0xFF42A5F5)]);
    return LinearGradient(colors: [Color(0xFF757575), Color(0xFF9E9E9E)]);
  }

  IconData _getIcon(String img) {
    if (img == 'eco') return Icons.eco;
    if (img == 'medical') return Icons.medical_services;
    if (img == 'agro') return Icons.agriculture;
    if (img == 'robotics') return Icons.precision_manufacturing;
    return Icons.shopping_bag;
  }
}
