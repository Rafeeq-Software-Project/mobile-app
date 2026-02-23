import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class VerifyButton extends StatelessWidget {
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onTap;

  const VerifyButton({
    super.key,
    required this.isEnabled,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.grey0,
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .3),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? colors.primary800 : colors.grey300,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          minimumSize: Size(double.infinity, 52.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.white),
                ),
              )
            : Text(
                'Verify & Continue',
                style: AppTextStyles.font16Bold.copyWith(color: colors.white),
              ),
      ),
    );
  }
}
