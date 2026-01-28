import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.font12SemiBold.copyWith(
          color: textColor ?? _getTextColor(color, colors),
        ),
      ),
    );
  }

  Color _getTextColor(Color backgroundColor, CustomAppColors colors) {
    // If background is light, use dark text
    final brightness = backgroundColor.computeLuminance();
    return brightness > 0.5 ? colors.grey800 : colors.grey0;
  }
}
