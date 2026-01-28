import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_colors/light_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customAppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 75.h),

            // ---------- ICON + GRADIENT ----------
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: LightAppColors.blueGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.customAppColors.primary700.withValues(
                      alpha: .15,
                    ),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.verified_rounded,
                  size: 60.w,
                  color: context.customAppColors.primary700,
                ),
              ),
            ),

            SizedBox(height: 50.h),

            // ---------- TITLE ----------
            Text(
              "Verification Code",
              style: AppTextStyles.font24Bold.copyWith(
                color: context.customAppColors.primary900,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.h),

            Text(
              "Enter the 4-digit code we sent to your email.",
              style: AppTextStyles.font14Regular.copyWith(
                color: context.customAppColors.grey700,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 35.h),

            // ---------- OTP BOXES ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => Container(
                  width: 65.w,
                  height: 65.w,
                  decoration: BoxDecoration(
                    color: context.customAppColors.grey50,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: context.customAppColors.grey200,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font20Bold.copyWith(
                        color: context.customAppColors.neutral800,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: "",
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 45.h),

            // ---------- VERIFY BUTTON ----------
            CustomButton(
              text: 'Verify',
              onTap: () {
                GoRouter.of(context).go(Routes.navbar);
              },
            ),
            SizedBox(height: 25.h),

            // ---------- RESEND ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn’t receive the code? ",
                  style: AppTextStyles.font14Regular.copyWith(
                    color: context.customAppColors.grey700,
                  ),
                ),
                Text(
                  "Resend",
                  style: AppTextStyles.font14Bold.copyWith(
                    color: context.customAppColors.primary800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
