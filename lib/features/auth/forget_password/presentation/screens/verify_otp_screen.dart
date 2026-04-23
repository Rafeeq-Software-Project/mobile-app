import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/resend_otp/resend_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/verify_otp/verify_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/widgets/resend_otp_bloc_listener.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/widgets/verify_otp_bloc_listener.dart';
import '../widgets/otp_app_bar.dart';
import '../widgets/otp_header.dart';
import '../widgets/otp_input_fields.dart';
import '../widgets/resend_code_button.dart';
import '../widgets/verify_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  int _resendCountdown = 60;
  bool _canResend = false;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _showContent = true;
        });
      }
    });
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
    context.read<VerifyOtpCubit>().verifyOtp(_otpCode);
  }

  void _resendCode() {
    if (!_canResend) return;

    context.read<ResendOtpCubit>().resendOtp(widget.email);
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

    return VerifyOtpBlocListener(
      child: Scaffold(
        backgroundColor: colors.grey0,
        body: SafeArea(
          child: Column(
            children: [
              OtpAppBar(onBackTap: () => Navigator.pop(context)),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _showContent ? 1 : 0,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 400),
                      offset: _showContent
                          ? Offset.zero
                          : const Offset(0, 0.05),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          OtpHeader(email: widget.email),
                          SizedBox(height: 40.h),
                          OtpInputFields(
                            controllers: _controllers,
                            focusNodes: _focusNodes,
                            onChanged: _onOtpChanged,
                            onBackspace: _onOtpBackspace,
                          ),
                          SizedBox(height: 32.h),
                          ResendOtpBlocListener(
                            onSuccess: () {
                              setState(() {
                                _canResend = false;
                                _resendCountdown = 60;
                              });
                              _startCountdown();
                            },
                            child: ResendCodeButton(
                              canResend: _canResend,
                              countdown: _resendCountdown,
                              onResend: _resendCode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedSlide(
                duration: const Duration(milliseconds: 400),
                offset: _showContent ? Offset.zero : const Offset(0, 0.2),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: _showContent ? 1 : 0,
                  child: VerifyButton(
                    isEnabled: _isOtpComplete,
                    isLoading: false,
                    onTap: _verifyOtp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
