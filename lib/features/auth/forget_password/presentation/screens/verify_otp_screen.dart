import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import '../widgets/otp_app_bar.dart';
import '../widgets/otp_header.dart';
import '../widgets/otp_input_fields.dart';
import '../widgets/resend_code_button.dart';
import '../widgets/verify_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, this.email = 'user@example.com'});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isVerifying = false;
  int _resendCountdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
        _startCountdown();
      } else if (mounted) {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  String get _otpCode {
    return _controllers.map((c) => c.text).join();
  }

  bool get _isOtpComplete {
    return _otpCode.length == 6;
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    setState(() {});
  }

  void _onOtpBackspace(int index) {
    if (index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  void _verifyOtp() async {
    if (!_isOtpComplete) return;

    setState(() {
      _isVerifying = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isVerifying = false;
      });

      GoRouter.of(context).go(Routes.resetPasswordScreen);
    }
  }

  void _resendCode() {
    if (!_canResend) return;

    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    _startCountdown();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification code sent!'),
        backgroundColor: CustomAppColors.of(context).accent600,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
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
            OtpAppBar(onBackTap: () => Navigator.pop(context)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Header
                    OtpHeader(email: widget.email),
                    SizedBox(height: 40.h),

                    // OTP Input Fields
                    OtpInputFields(
                      controllers: _controllers,
                      focusNodes: _focusNodes,
                      onChanged: _onOtpChanged,
                      onBackspace: _onOtpBackspace,
                    ),
                    SizedBox(height: 32.h),

                    // Resend Code
                    ResendCodeButton(
                      canResend: _canResend,
                      countdown: _resendCountdown,
                      onResend: _resendCode,
                    ),
                  ],
                ),
              ),
            ),

            // Verify Button
            VerifyButton(
              isEnabled: _isOtpComplete && !_isVerifying,
              isLoading: _isVerifying,
              onTap: _verifyOtp,
            ),
          ],
        ),
      ),
    );
  }
}
