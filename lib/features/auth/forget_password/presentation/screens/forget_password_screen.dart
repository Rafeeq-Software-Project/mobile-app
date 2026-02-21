import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/common/widgets/custom_app_bar.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/send_otp/send_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/widgets/send_otp_bloc_listener.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SendOtpBlocListener(
      child: Scaffold(
        backgroundColor: context.customAppColors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
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
                Text(
                  "Enter your email and we’ll send you a link to reset your password.",
                  style: AppTextStyles.font14Regular.copyWith(
                    color: context.customAppColors.grey700,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Email Address",
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: context.customAppColors.neutral800,
                  ),
                ),
                SizedBox(height: 8.h),
                AppTextFormField(
                  hintText: 'Enter your Email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 40.h),
                CustomButton(
                  text: 'Send Reset Link',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SendOtpCubit>().sendOtp(
                        emailController.text.trim(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
