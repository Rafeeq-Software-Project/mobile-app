import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/helpers/app_regex.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import 'package:rafeeq_app/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.h.ph,
                  Text(
                    S.of(context).login_welcome_back,
                    style: AppTextStyles.font24Bold.copyWith(
                      color: context.customAppColors.grey900,
                    ),
                  ),
                  10.h.ph,
                  Text(
                    S.of(context).login_welcome_subtitle,
                    style: AppTextStyles.font16Regular.copyWith(
                      color: context.customAppColors.grey600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  30.h.ph,
                  AppTextFormField(
                    controller: emailController,
                    hintText: S.of(context).login_email_hint,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!AppRegex.isEmailValid(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  15.h.ph,
                  AppTextFormField(
                    controller: passwordController,
                    hintText: S.of(context).login_password_hint,
                    isObscureText: obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (!AppRegex.isPasswordValid(value)) {
                        return "Password must contain upper, lower, number, special char and min 8 chars";
                      }
                      return null;
                    },
                  ),
                  20.h.ph,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).login_forgot_password,
                        style: TextStyle(
                          color: context.customAppColors.primary700,
                        ),
                      ),
                    ),
                  ),
                  20.h.ph,
                  CustomButton(
                    text: S.of(context).login_sign_in,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  15.h.ph,
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          S.of(context).login_or,
                          style: AppTextStyles.font14Regular,
                        ),
                      ),
                      Expanded(
                        child: Divider(color: context.customAppColors.grey400),
                      ),
                    ],
                  ),
                  15.h.ph,
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppIcons.googleIcon,
                      width: 20.w,
                      height: 20.h,
                    ),
                    label: Text(S.of(context).login_google_signin),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 32.w,
                      ),
                    ),
                  ),
                  20.h.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).login_no_account,
                        style: AppTextStyles.font14Regular,
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(Routes.register);
                        },
                        child: Text(
                          S.of(context).login_sign_up,
                          style: TextStyle(
                            color: context.customAppColors.primary700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
