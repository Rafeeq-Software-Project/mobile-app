import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onTap;
  final Color borderColor;
  final Color? textColor;
  final Color? backgroundColor;

  const SocialButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onTap,
    this.borderColor = Colors.grey,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: SvgPicture.asset(iconPath, width: 20.w, height: 20.h),
        label: Text(
          text,
          style: AppTextStyles.font14Regular.copyWith(
            color: textColor ?? context.customAppColors.grey900,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
