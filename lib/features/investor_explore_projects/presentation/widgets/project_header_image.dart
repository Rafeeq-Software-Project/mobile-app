import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ProjectHeaderImage extends StatelessWidget {
  final String imageUrl;
  final String stage;

  const ProjectHeaderImage({
    super.key,
    required this.imageUrl,
    required this.stage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Stack(
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.location_city,
              size: 64.sp,
              color: colors.white.withOpacity(0.3),
            ),
          ),
        ),
        Positioned(
          bottom: 16.h,
          left: 20.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: colors.primary700,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              stage,
              style: AppTextStyles.font12Bold.copyWith(color: colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
