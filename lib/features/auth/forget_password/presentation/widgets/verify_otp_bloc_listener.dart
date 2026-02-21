import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_alert_dialog.dart';
import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/verify_otp/verify_otp_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/verify_otp/verify_otp_state.dart';

class VerifyOtpBlocListener extends StatelessWidget {
  const VerifyOtpBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyOtpCubit, VerifyOtpState>(
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
          success: (response) {
            context.pop();
            context.push(
              Routes.resetPasswordScreen,
              extra: response.resetToken,
            );
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
        dialogHeader: 'OTP is not correct',
        dialogBody: error,
        dialogIcon: Icons.error,
        press: () => context.pop(),
      ),
    );
  }
}
