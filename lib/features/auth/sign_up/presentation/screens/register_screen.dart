import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  final List<String> roles = [
    "Volunteer",
    "Service Seeker",
    "Founder",
    "Investor",
  ];

  String? selectedRole;

  @override
  void dispose() {
    usernameController.dispose();
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
                    "Create Your Account",
                    style: AppTextStyles.font24Bold.copyWith(
                      color: context.customAppColors.grey900,
                    ),
                  ),
                  10.h.ph,
                  Text(
                    "Join the network and start your journey",
                    style: AppTextStyles.font16Regular.copyWith(
                      color: context.customAppColors.grey600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  30.h.ph,

                  /// Username
                  AppTextFormField(
                    controller: usernameController,
                    hintText: "Username",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username is required";
                      }
                      return null;
                    },
                  ),

                  15.h.ph,

                  /// Email
                  AppTextFormField(
                    controller: emailController,
                    hintText: "Email",
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

                  /// Password
                  AppTextFormField(
                    controller: passwordController,
                    hintText: "Password",
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
                        return "Weak password";
                      }
                      return null;
                    },
                  ),

                  15.h.ph,

                  /// Select Role
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: context.customAppColors.grey400,
                      ),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: const Text("Select Role"),
                      items: roles.map((role) {
                        return DropdownMenuItem(value: role, child: Text(role));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? "Please select a role" : null,
                    ),
                  ),

                  25.h.ph,

                  /// Register Button
                  CustomButton(
                    text: "Sign Up",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: connect register logic
                      }
                    },
                  ),

                  20.h.ph,
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

                  /// Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppTextStyles.font14Regular,
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(Routes.login);
                        },
                        child: Text(
                          "Sign In",
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
