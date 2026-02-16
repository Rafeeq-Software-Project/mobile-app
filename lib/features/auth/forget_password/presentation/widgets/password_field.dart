import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscureText;
  final VoidCallback onVisibilityToggle;
  final Function(String)? onChanged;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.obscureText,
    required this.onVisibilityToggle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.font14SemiBold.copyWith(color: colors.black),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: controller.text.isNotEmpty
                  ? colors.primary700
                  : colors.grey300,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            style: AppTextStyles.font14Regular.copyWith(color: colors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.font14Regular.copyWith(
                color: colors.grey400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: colors.grey500,
                ),
                onPressed: onVisibilityToggle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
