import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ActionLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const ActionLink({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.font14SemiBold.copyWith(color: colors.grey900),
          ),
          SizedBox(width: 4.w),
          Icon(icon ?? Icons.arrow_forward, color: colors.grey900, size: 18.sp),
        ],
      ),
    );
  }
}
