import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';

class AttachmentMenu extends StatelessWidget {
  final VoidCallback? onVideoTap;
  final VoidCallback? onImageTap;
  final VoidCallback? onDocumentTap;

  const AttachmentMenu({
    super.key,
    this.onVideoTap,
    this.onImageTap,
    this.onDocumentTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.primary300,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMenuItem(
            iconUrl: AppIcons.videosIcon,
            label: 'فيديوهات',
            colors: colors,
            onTap: onVideoTap,
          ),
          _buildMenuItem(
            iconUrl: AppIcons.photosIcon,
            label: 'صور',
            colors: colors,
            onTap: onImageTap,
          ),
          _buildMenuItem(
            iconUrl: AppIcons.documentsIcon,
            label: 'مستندات',
            colors: colors,
            onTap: onDocumentTap,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconUrl,
    required String label,
    required CustomAppColors colors,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primary800,
            ),
            child: Center(child: SvgPicture.asset(iconUrl)),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: AppTextStyles.font14Bold.copyWith(color: colors.grey900),
          ),
        ],
      ),
    );
  }
}
