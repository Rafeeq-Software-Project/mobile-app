import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class PasswordRequirements extends StatelessWidget {
  final bool hasMinLength;
  final bool hasNumberAndSymbol;
  final bool passwordsMatch;

  const PasswordRequirements({
    super.key,
    required this.hasMinLength,
    required this.hasNumberAndSymbol,
    required this.passwordsMatch,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PASSWORD REQUIREMENTS',
            style: AppTextStyles.font12Bold.copyWith(
              color: colors.grey700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          _buildRequirement('At least 8 characters', hasMinLength, colors),
          SizedBox(height: 8.h),
          _buildRequirement(
            'At least 1 number & 1 symbol',
            hasNumberAndSymbol,
            colors,
          ),
          SizedBox(height: 8.h),
          _buildRequirement('Both passwords match', passwordsMatch, colors),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet, CustomAppColors colors) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 20.sp,
          color: isMet ? colors.accent600 : colors.grey400,
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: AppTextStyles.font14Regular.copyWith(
            color: isMet ? colors.grey800 : colors.grey600,
          ),
        ),
      ],
    );
  }
}
