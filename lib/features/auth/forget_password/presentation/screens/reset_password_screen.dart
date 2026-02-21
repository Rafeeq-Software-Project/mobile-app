import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/features/auth/forget_password/data/models/reset_password/reset_password_request_model.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/reset_password/reset_password_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/widgets/reset_password_bloc_listener.dart';
import '../widgets/reset_header.dart';
import '../widgets/password_field.dart';
import '../widgets/password_requirements.dart';
import '../widgets/reset_password_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.resetToken});
  final String resetToken;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
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

  void _resetPassword() {
    if (!_isFormValid) return;

    final model = ResetPasswordRequestModel(
      resetToken: widget.resetToken,
      newPassword: _newPasswordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
    );

    context.read<ResetPasswordCubit>().resetPassword(model);
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

    return ResetPasswordBlocListener(
      child: Scaffold(
        backgroundColor: colors.grey50,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        const ResetHeader(),
                        SizedBox(height: 32.h),
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
                        PasswordField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          hint: 'Re-enter password',
                          obscureText: _obscureConfirmPassword,
                          onVisibilityToggle: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 32.h),
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
                isEnabled: _isFormValid,
                isLoading: false,
                onTap: _resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
