import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ImageUploadCard extends StatelessWidget {
  final String? imagePath;
  final Function(String) onImageSelected;

  const ImageUploadCard({
    super.key,
    this.imagePath,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return GestureDetector(
      onTap: () {
        // Simulate image selection
        onImageSelected('path/to/image.jpg');
      },
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: imagePath != null
                ? [colors.accent600, colors.primary800]
                : [colors.grey200, colors.grey300],
          ),
          boxShadow: [
            BoxShadow(
              color: colors.grey300.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Image placeholder or actual image
            if (imagePath != null)
              Center(
                child: Icon(
                  Icons.image,
                  size: 64.sp,
                  color: colors.grey0.withValues(alpha: 0.5),
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 48.sp,
                      color: colors.grey600,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Upload Cover Image',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Tap to select',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.grey600,
                      ),
                    ),
                  ],
                ),
              ),

            // Edit/Upload Button
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colors.grey0,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors.grey400.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  imagePath != null ? Icons.edit : Icons.upload,
                  size: 20.sp,
                  color: colors.grey700,
                ),
              ),
            ),

            // Image label (if uploaded)
            if (imagePath != null)
              Positioned(
                bottom: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: colors.grey0.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16.sp,
                        color: colors.accent600,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Image uploaded',
                        style: AppTextStyles.font12SemiBold.copyWith(
                          color: colors.grey800,
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
}
