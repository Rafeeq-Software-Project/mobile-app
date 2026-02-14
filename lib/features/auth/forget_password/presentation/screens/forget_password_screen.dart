import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/common/widgets/custom_app_bar.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customAppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.ph,
            CustomAppBar(text: ''),
            SizedBox(height: 40.h),
            Text(
              "Forgot Password",
              style: AppTextStyles.font24Bold.copyWith(
                color: context.customAppColors.primary800,
              ),
            ),
            SizedBox(height: 8.h),
            // ---------- Subtitle ----------
            Text(
              "Enter your email and we’ll send you a link to reset your password.",
              style: AppTextStyles.font14Regular.copyWith(
                color: context.customAppColors.grey700,
              ),
            ),
            SizedBox(height: 40.h),

            // ---------- Email label ----------
            Text(
              "Email Address",
              style: AppTextStyles.font14SemiBold.copyWith(
                color: context.customAppColors.neutral800,
              ),
            ),
            SizedBox(height: 8.h),

            // ---------- TextField ----------
            AppTextFormField(hintText: 'Enter your Email'),

            SizedBox(height: 40.h),

            // ---------- Send Button ----------
            CustomButton(text: 'Send Reset Link'),
          ],
        ),
      ),
    );
  }
}
