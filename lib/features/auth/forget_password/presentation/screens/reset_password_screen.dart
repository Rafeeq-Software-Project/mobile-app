import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import '../widgets/reset_app_bar.dart';
import '../widgets/reset_header.dart';
import '../widgets/password_field.dart';
import '../widgets/password_requirements.dart';
import '../widgets/reset_password_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isResetting = false;

  // Password requirements state
  bool get _hasMinLength => _newPasswordController.text.length >= 8;
  bool get _hasNumberAndSymbol {
    final password = _newPasswordController.text;
    return password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool get _passwordsMatch =>
      _newPasswordController.text.isNotEmpty &&
      _newPasswordController.text == _confirmPasswordController.text;

  bool get _isFormValid =>
      _hasMinLength && _hasNumberAndSymbol && _passwordsMatch;

  void _resetPassword() async {
    if (!_isFormValid) return;

    setState(() {
      _isResetting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isResetting = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset successfully!'),
          backgroundColor: CustomAppColors.of(context).accent600,
        ),
      );

      GoRouter.of(context).go(Routes.login);
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Scaffold(
      backgroundColor: colors.grey50,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            ResetAppBar(onBackTap: () => Navigator.pop(context)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      // Header
                      const ResetHeader(),
                      SizedBox(height: 32.h),

                      // New Password Field
                      PasswordField(
                        controller: _newPasswordController,
                        label: 'New Password',
                        hint: 'Minimum 8 characters',
                        obscureText: _obscureNewPassword,
                        onVisibilityToggle: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Confirm Password Field
                      PasswordField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Re-enter password',
                        obscureText: _obscureConfirmPassword,
                        onVisibilityToggle: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 32.h),

                      // Password Requirements
                      PasswordRequirements(
                        hasMinLength: _hasMinLength,
                        hasNumberAndSymbol: _hasNumberAndSymbol,
                        passwordsMatch: _passwordsMatch,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Reset Button
            ResetPasswordButton(
              isEnabled: _isFormValid && !_isResetting,
              isLoading: _isResetting,
              onTap: _resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
