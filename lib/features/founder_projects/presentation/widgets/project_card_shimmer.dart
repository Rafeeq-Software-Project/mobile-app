import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ProjectCardShimmer extends StatelessWidget {
  const ProjectCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.grey50,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _pill(),
                SizedBox(width: 8.w),
                _pill(),
                const Spacer(),
                _circle(),
              ],
            ),
            SizedBox(height: 14.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Colors.white,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 12.h,
              color: Colors.white,
            ),
            SizedBox(height: 6.h),
            Container(width: 220.w, height: 12.h, color: Colors.white),
            SizedBox(height: 18.h),
            Container(width: double.infinity, height: 8.h, color: Colors.white),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 90.w, height: 14.h, color: Colors.white),
                _pill(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill() {
    return Container(
      width: 80.w,
      height: 24.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }

  Widget _circle() {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
