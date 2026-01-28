import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

import '../../../../core/theme/app_colors/custom_app_colors.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final bool isOutlined;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.isOutlined,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined ? colors.grey0 : colors.primary800,
        foregroundColor: isOutlined ? colors.grey800 : colors.grey0,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(
            color: isOutlined ? colors.grey300 : colors.primary700,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isOutlined && label == 'Accept')
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Icon(Icons.check, size: 16.sp, color: colors.grey0),
            ),
          Text(
            label,
            style: AppTextStyles.font14SemiBold.copyWith(
              color: isOutlined ? colors.grey800 : colors.grey0,
            ),
          ),
        ],
      ),
    );
  }
}
