import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_alert_dialog.dart';
import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/resend_otp/resend_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/resend_otp/resend_otp_state.dart';

class ResendOtpBlocListener extends StatelessWidget {
  const ResendOtpBlocListener({
    super.key,
    required this.child,
    required this.onSuccess,
  });

  final Widget child;
  final VoidCallback onSuccess;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResendOtpCubit, ResendOtpState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CustomLoading(size: 100)),
            );
          },

          success: (_) {
            context.pop();
            onSuccess();
          },
          failure: (error) {
            context.pop();
            _showErrorDialog(context, error);
          },
        );
      },
      child: child,
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        dialogColor: Colors.redAccent,
        dialogHeader: 'Send OTP Failed',
        dialogBody: error,
        dialogIcon: Icons.error,
        press: () => context.pop(),
      ),
    );
  }
}
