import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected
                ? context.customAppColors.primary500
                : Colors.grey.shade400,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? context.customAppColors.primary500.withValues(alpha: .08)
              : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: selected
                  ? context.customAppColors.primary500
                  : Colors.grey,
            ),
            8.h.ph,
            Text(
              title,
              style: AppTextStyles.font14Regular.copyWith(
                color: selected
                    ? context.customAppColors.primary700
                    : Colors.grey,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
