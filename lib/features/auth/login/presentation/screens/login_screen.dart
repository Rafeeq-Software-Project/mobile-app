import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/common/widgets/social_button.dart';
import 'package:rafeeq_app/core/helpers/app_regex.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import 'package:rafeeq_app/features/auth/login/data/models/login_request_model.dart';
import 'package:rafeeq_app/features/auth/login/presentation/logic/login_cubit/login_cubit.dart';
import 'package:rafeeq_app/features/auth/login/presentation/widgets/login_bloc_listener.dart';
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
      backgroundColor: context.customAppColors.background,
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
                  FadeInDown(
                    duration: Duration(milliseconds: 600),
                    child: Text(
                      S.of(context).login_welcome_back,
                      style: AppTextStyles.font24Bold.copyWith(
                        color: context.customAppColors.grey900,
                      ),
                    ),
                  ),
                  10.h.ph,
                  FadeIn(
                    delay: Duration(milliseconds: 150),
                    duration: Duration(milliseconds: 600),
                    child: Text(
                      S.of(context).login_welcome_subtitle,
                      style: AppTextStyles.font16Regular.copyWith(
                        color: context.customAppColors.grey600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  30.h.ph,
                  FadeInLeft(
                    delay: Duration(milliseconds: 300),
                    duration: Duration(milliseconds: 500),
                    child: AppTextFormField(
                      controller: emailController,
                      hintText: S.of(context).login_email_hint,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).validation_email_required;
                        }
                        if (!AppRegex.isEmailValid(value)) {
                          return S.of(context).validation_email_invalid;
                        }
                        return null;
                      },
                    ),
                  ),
                  20.h.ph,
                  FadeInRight(
                    delay: Duration(milliseconds: 450),
                    duration: Duration(milliseconds: 500),
                    child: AppTextFormField(
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
                          return S.of(context).validation_password_required;
                        }
                        if (!AppRegex.isPasswordValid(value)) {
                          return S.of(context).validation_password_invalid;
                        }
                        return null;
                      },
                    ),
                  ),
                  20.h.ph,
                  FadeIn(
                    delay: Duration(milliseconds: 600),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(Routes.forgetPassword);
                        },
                        child: Text(
                          S.of(context).login_forgot_password,
                          style: TextStyle(
                            color: context.customAppColors.primary700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  20.h.ph,
                  ElasticIn(
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 600),
                    child: CustomButton(
                      text: S.of(context).login_sign_in,
                      onTap: () {
                        validateThenDoLogin(context);
                      },
                    ),
                  ),
                  LoginBlocListener(),
                  15.h.ph,
                  FadeIn(
                    delay: Duration(milliseconds: 850),
                    duration: Duration(milliseconds: 500),
                    child: Row(
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
                          child: Divider(
                            color: context.customAppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.h.ph,
                  FadeInUp(
                    delay: Duration(milliseconds: 1000),
                    duration: Duration(milliseconds: 500),
                    child: SocialButton(
                      text: S.of(context).login_google_signin,
                      iconPath: AppIcons.googleIcon,
                      onTap: () {},
                    ),
                  ),
                  10.h.ph,
                  FadeInUp(
                    delay: Duration(milliseconds: 1300),
                    duration: Duration(milliseconds: 500),
                    child: SocialButton(
                      text: S.of(context).login_facebook_signin,
                      iconPath: AppIcons.facebookIcon,
                      onTap: () {},
                    ),
                  ),
                  20.h.ph,
                  FadeInUp(
                    delay: Duration(milliseconds: 1150),
                    duration: Duration(milliseconds: 400),
                    child: Row(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }
}
