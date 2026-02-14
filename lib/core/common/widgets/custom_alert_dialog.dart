import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/spacing.dart';
import '../../theme/app_colors/light_app_colors.dart';
import '../../theme/app_texts/app_text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  final String dialogHeader;
  final String dialogBody;
  final Color dialogColor;
  final IconData dialogIcon;

  final VoidCallback press;

  const CustomAlertDialog({
    super.key,
    required this.dialogIcon,
    required this.dialogHeader,
    required this.dialogBody,
    required this.dialogColor,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: LightAppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: dialogColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12.r),
              child: Container(
                decoration: BoxDecoration(
                  color: dialogColor.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10.r),
                child: Center(
                  child: Icon(
                    dialogIcon,
                    size: 30.r,
                    color: LightAppColors.white,
                  ),
                ),
              ),
            ),

            verticalSpace(20),

            Text(
              dialogHeader,
              style: AppTextStyles.font18Bold.copyWith(
                color: LightAppColors.grey900,
              ),
            ),

            verticalSpace(14),

            Text(
              dialogBody,
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular.copyWith(
                color: LightAppColors.grey600,
              ),
            ),
            verticalSpace(26),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: press,
                style: TextButton.styleFrom(
                  backgroundColor: dialogColor,
                  padding: EdgeInsets.symmetric(vertical: 14.r),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'OK',
                  style: AppTextStyles.font14Regular.copyWith(
                    color: LightAppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
