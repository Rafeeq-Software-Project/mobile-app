import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ProgressBar extends StatelessWidget {
  final double percentage;
  final Color color;

  const ProgressBar({super.key, required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // background
            Container(
              height: 6.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.primary700,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),

            // progress
            Container(
              height: 6.h,
              width: constraints.maxWidth * (percentage / 100).clamp(0.0, 1.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ],
        );
      },
    );
  }
}
