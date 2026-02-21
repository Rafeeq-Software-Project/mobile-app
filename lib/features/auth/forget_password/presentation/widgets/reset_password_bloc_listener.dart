import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_alert_dialog.dart';
import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/reset_password/reset_password_cubit.dart';
import 'package:rafeeq_app/features/auth/forget_password/presentation/logic/reset_password/reset_password_state.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
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
            Navigator.of(context, rootNavigator: true).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password reset successfully")),
            );

            context.go(Routes.login);
          },

          failure: (error) {
            Navigator.of(context, rootNavigator: true).pop();
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
        dialogHeader: 'Reset Password Failed',
        dialogBody: error,
        dialogIcon: Icons.error,
        press: () => context.pop(),
      ),
    );
  }
}
